Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1365C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 03:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F2B6128B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 03:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4F2B6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB7789E33;
	Tue,  9 Nov 2021 03:25:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C77589E9E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 03:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT4NjNxjp3bKFk4/aZKIWIJxYiaxEhy7I2K3KHeli/usQ8wLI9yoMFeUmaBxe6PZ5MToUuDNClC49iu3wjXrMWRJIr68S64JSh6bvq4hEDs4aScn2pUb0e2OX+8GknAGmf/l5PfY/1WNyc9Gt44Oe51pUJ9VU37d5ssIiCWOvzJsmPbacinjq02TWvPPQduJlZx0QlbOtjQUItg9K2jbstXZ8ugupst7OGwp67fIc+m/w+pQb6MlPclDPWo1Qb7kKIyzP9kOzXTBjdp3hfDcQli/XJjf0P9mMGPMtynh5zX98PyjnFXVd2oXaU1f4afo1T9ToQd/NRAtNsvc6vEeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7WbQQ1gO0oFfOpknNjcRJlkb2XcMaqcE+Wvf3W1ojk=;
 b=QFxJs4YZnBNRYfC1dxuh5aFhT+bzhx4wqhTwM94pV7qoOYTbrzXFsCXVMnV43sgYV13tzBKZ/uZRL0wVT1xHWOBJXXLu5Oyivw9W1upO3R/vTmzWom0sUxeDVzuMYwsyXw69JlIG1Inx9kSpkilKBtgVU4/moZi6C1mQIW9spShZ2/GnRI2C50y54Wjyp3gQbQboY4ViV0He1g9hLcaT1w/B4mmhD4QcVrES+pdC5ZtrSgFpLB/SNFYYQGhu+LvFOcKwaEcxD3bvTQLGyCZtt1AvWEosvRCHgEk8aAc4K9QTlyK9WX3+DlzfgcoHeT5b3f8kRkgXdx0QYSX9lBlavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7WbQQ1gO0oFfOpknNjcRJlkb2XcMaqcE+Wvf3W1ojk=;
 b=AEXNkactlzzeUqhv06dnyzUnwj4JacKSOnf9QhhDNv6TtTBVKae/kbNM2YEfmC2M+UiiJqMTXsienpoNhy3oNPwAL5j+Z/RfsU9Ui519vCEJxdIww50U2Eq/UqGCMLMqWv0jlhsW2EUm8y0ygGiXsH/U6rFK2BHcXA90r7iqS1s=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Tue, 9 Nov 2021 03:25:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 03:25:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Borislav Petkov <bp@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Topic: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Index: AQHX1FvEu+OweiWVMEOG0w2/0y3AtKv5Us2AgAAoOYCAAQ74cA==
Date: Tue, 9 Nov 2021 03:25:25 +0000
Message-ID: <DM6PR12MB261945DF42D537634E1AA613E4929@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic>
In-Reply-To: <YYkGteomN5Cbh1+C@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-09T03:25:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6830d834-7705-4904-923e-3d1b9aff9a50;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bca5c065-0a72-4b36-dab7-08d9a3309223
x-ms-traffictypediagnostic: DM5PR12MB1866:
x-microsoft-antispam-prvs: <DM5PR12MB18667DC3BB1BB4890F5E009EE4929@DM5PR12MB1866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mk9Flzzf/p5zO35hVvZlUNZjOO9Af+0PtgblBHMFZv7+AeUe4f5XcgbVdsts9bKusvAFVg9BAc+1GwIEInee3DGP9JIFtDh2tf/Oqr2Sgtq7LpO2X5Cg3SepwqQ53xMAUaQIFc6kzGMWNC1zrxPne+aP2X1qBmS9v14Yxwth4bycLkQvT16aCPhS35mJBzegDLNnPyEVZFNz4ivn+GnrH7q90OM59lL4rOz8i8bUCsbaup5W6cIwhLdFXIW+WX+nuXpVh5UTcslKQXlrlmRjBJLtq2iS48aB8zozbbJanmz31Iy7mqIILvlp7/xdgjKHxOCSzzxXi5LZkgrbOmS7vxcUvBPh7ETBAZjkHYZ1Nut5oFPex+tJHlVHMBQ9LlXIarzSRANGZzETMQ0g8i0vLh7uIv+ILWPbrVKMla8D3WeWalKpNC1CxcUywjOTMXznZRQn64zLgWkCVMVxwx67lXcBNYmQ33tKSEsXc1s1S7lRvWS9J+tSDXdD+jH4bqJ5hA5X285ubDFGY9E5/4y/nZK9/iTul5E/x6W4yGjRQVrLgeu/gyrvJS/ol3MCSviWJ0lDOfDqQ0tBT8aOSLCydCW2hacanJebp8gz00phQD/tzY26qGi9NXkqlOoKLkr3i5NGI4V18nnUoxdBcesgCqZUD87QAGGgTYHu+z3LlmFlrczH5njrllH3WB2q0rXy3cbUJndYNrD2WHU6mIpcbwZMbZwfuUIobTmKud/ZHkpkYZDoS5drBViOMSnBePQWWYwGCCkheuPmkhXBT9QGInsEIxnUJvjGs4Njrz+hXEo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(64756008)(66476007)(8936002)(66946007)(38070700005)(5660300002)(110136005)(316002)(83380400001)(54906003)(38100700002)(8676002)(76116006)(33656002)(86362001)(55016002)(71200400001)(4326008)(508600001)(45080400002)(9686003)(186003)(7696005)(53546011)(966005)(26005)(6506007)(122000001)(66556008)(66446008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lLmYm2qFcnqOUzFLKHa0X6qnigmxeRAI7eatmjHo3LxfhB5n6d8zxdbD24?=
 =?iso-8859-1?Q?6QSsjiwoX2wjf9yGweJqWBTUxuiz9wbaBlLzibjw/j645LdXubTCPhzL8/?=
 =?iso-8859-1?Q?YkIQV/Aa5izRsawzv0B6ceFyFAPtBcHwqnMKVWcpeGJzIgYPWHHa5q6rC+?=
 =?iso-8859-1?Q?3Nobdje2tSVV3VBPrNk5iKkG36Son3SZVt/jlBeN8VDMk49TX2H5OKTlEI?=
 =?iso-8859-1?Q?5jTuWviozrhh1qiaSu/eulrbSr5aJPs9flz8ZKZTBHzxJ1pwgvk3LBKh11?=
 =?iso-8859-1?Q?dZCdMp2uR1+H0ErQjmEfWmQgU1l+DW+v440682fbSpjhHrcy5A5dlHC3g7?=
 =?iso-8859-1?Q?2EBdeGy61MFEebVDfB1AhMV13wTLr0NXTQBncLCTIRREZbOZo90Y8R+aXQ?=
 =?iso-8859-1?Q?eQ616vlLB56lYtYO20Kwlxy2TewbQD+QqpkqAPl5XTMWpffyWex8bQCa+k?=
 =?iso-8859-1?Q?BrgrJJhw0vdSwbIztSs1pGH3iK7Yhq7MJpk5sOpJCdRFerDP94pz7/HT4g?=
 =?iso-8859-1?Q?psaU9UsAo5MmuDIWbY2Hnvly03+z65UG99KaufPTBhR+mR/CABPu+3+J5Z?=
 =?iso-8859-1?Q?NBuTs/gdlfa8wgXolt5dXV2dxYSunGIbNcp32ntbrwEaBbXFJXIZcnHJwV?=
 =?iso-8859-1?Q?i4P5z6Ojq8iFjk0QJ3QB8JVvxHl0IvZ6+MtEkFlyzJnLeocDh9nPMOCBk5?=
 =?iso-8859-1?Q?IQY0cFUY785o+vtiyvZD4FhoNni+LgwZYa8DWQaQZQy1j+mnKLhl9sc3ll?=
 =?iso-8859-1?Q?ulxDeP0M4Fj4Y4fHkITDEgn6LF8hNfct8EUp8mbzRDeANCDUCaNM/yWu05?=
 =?iso-8859-1?Q?fj/eX9V5l5nRChkMK6N/IEibZmWNBlNR2RfOUoa0Du4pkHke3EZHRK+2rB?=
 =?iso-8859-1?Q?xNdhaxUltW2gGcUlyrmMalp73U39iQKzK7vc9hopvWMVtwsk+reOZFYsmg?=
 =?iso-8859-1?Q?dk6yepLuCj5q99TpoVotVZLN0EXgWFuxU7LxaI9EI4BeVh6pfx/utL27rU?=
 =?iso-8859-1?Q?ucGOrSfhhs/h2zy08hdNnspuPF/Q4QOScz/Hz2znqJXFtwwkWWfMY99PUS?=
 =?iso-8859-1?Q?/FExKW+rg3ukl4FrxZ+1/M/ZXyZJ1AkwC7dGvKBXYOP8RgAiXu2f9BGoeP?=
 =?iso-8859-1?Q?MHkPCG6/+bz76cKrl75CPwRqOoSJK6xxwDwSRqoP89YVX+6CnHkrdn3cw1?=
 =?iso-8859-1?Q?+6G8mxGfEBY51gye3ers1j/rNBbNNszTmmGLLbUFP591ZaNqNuZ613j2Pw?=
 =?iso-8859-1?Q?szMVCxkOEVc0bjwR8VfAKUNzJk4HfrcZIC0hz9gX3Pht1+/HcQGjpT0KVR?=
 =?iso-8859-1?Q?MdBnmEkhRFjiY8rlcYw4skHsPAKHW8H2Aqem078+8JfB0sN36zjRZDLSkb?=
 =?iso-8859-1?Q?4f3xYV/w5iz2Ncl2z7lrdkwI9dGSdi1YDK5i0CJ/KU7LvZ5kTRiIVqpVt7?=
 =?iso-8859-1?Q?9s8ru0lOphdDaQiO43q9GRNvxdZR/7yOeqP4Hp7An0dPuSpzxuBO2j9cOz?=
 =?iso-8859-1?Q?TpWnbpjlwIU3fMThSJ6+3qJ+fSmYcd5PTSbKTU9CxwGff1EclvzczMs0PK?=
 =?iso-8859-1?Q?N+DpTGaPwewQOW3+gHEANcyhFk99BrnWpdi3kHakcZAe6Zt1d+lSv4GcA9?=
 =?iso-8859-1?Q?QVWaWtURQK5mY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca5c065-0a72-4b36-dab7-08d9a3309223
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 03:25:25.3687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvZMX6UIYKfR0waza0bBUiUPWaQ5PIybEPhfxBQhbnno1kFca6fXi7uM4bwOQeh7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@suse.de>
> Sent: Monday, November 8, 2021 7:15 PM
> To: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate
> setting
>=20
> On Mon, Nov 08, 2021 at 09:51:03AM +0100, Paul Menzel wrote:
> > Please elaborate the kind of issues.
>=20
> It fails to reboot on Carrizo-based laptops.
>=20
> Whoever commits this, pls add
>=20
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2FYV81vidWQLWvATMM%40zn.tnic&amp;data=3D04%7C01%7
> Cevan.quan%40amd.com%7C274191d3b11c4ba6dc5208d9a2a906d4%7C3dd8
> 961fe4884e608e11a82d994e183d%7C0%7C0%7C637719669118839695%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJAfoXZHWV6KoCxsSJR4plt5
> P%2FeXzTodZJeAUMPU5kYg%3D&amp;reserved=3D0
>=20
> so that it is clear what the whole story way.
[Quan, Evan] Thanks. Will add this.

BR
Evan
>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG
> N=FCrnberg
