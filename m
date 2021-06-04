Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A832C47083
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3985161405
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3985161405
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D956E89A;
	Fri,  4 Jun 2021 04:51:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9EB6E89A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 04:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg/YFJjp41WXoAMJ6v9wpz+ikKKKa4WhnMs/HUuRUaXgMJm0KIRp3xFEQvxDwaWhHhbYBi9y/zVBAFgS0Hib9BE0ckfZNs80zzOBPhEka/0y5vwEp9Bvph0qzNnuD42Kaep7lMaIEoe0p3QNYqN03m1Vg7UAJN6a19UOLj9SVGMznyfRWEgSo2bRFBCPg/FQ4OAhcfF/xdAj7pdQPvtUiqrE/hk/9GdKu+2Cdxrr5h9qvaK0glKm/DzBeXkWuSeogi0KPxadujYmmoK7X/Gc53jn8hgOh5SmaOw29XjD58+OCZyS+cC8sj6jliZ40Fqz3N8REv2PpPD/5hhA6cztWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fonI+ABZwmYEqFLzeUdMGyfXEkWoVJsgyWeomeXuY8s=;
 b=VES23LNtHZRWrd/zL/Xn1mwvnvlZLb9KDss5yB3PQ9Dcig+qg/aE6sG+eA5HSGxT/MUgX1KnCXIZc/eDnwNvY83LQrL+zA/DaqxuJAd9zmwEZ7JZhsJJjXHh0L2sjjLU6G1AcGszv2lFVIEaA7vj+TatdhsMqJdSUpefKorpk77EsCnmb/s3Ba7jSTji/Ban9AD3qy9+dJ1jeyDdf99y4IMVmfFx9nywq0087SXBQnSvi2QzL8d4tVzrXsnYtRkc4WhAOEziVVaNhPoZ4NM2TvW2JRATTf331Vgu7HFvw+LP2NRFuQkBOi0/iblTNEiAbmsXlPETaj6wAdCXdRRkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fonI+ABZwmYEqFLzeUdMGyfXEkWoVJsgyWeomeXuY8s=;
 b=Zdxq7D/Y9MIKAwVzyFC91banUsNcYOfOULzM7EnQr6Wf1ZuCqYKH56v6vJ27599MbBuSVfqLCuDrWn5YlXQs287sX5eYLDZbd1KCzkUbQy52JWBSoLTQJbRbHa2FYcTpA+eRFV9rX+h1THfDARcriKDVGn9TiBo2Xdb//prwWko=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 04:51:52 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 04:51:52 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXVxHnYPEHUtcMDUObTN9iSTFtEasAI9aAgAIhzoCAAAb8kIAA1K+AgAAnpbA=
Date: Fri, 4 Jun 2021 04:51:52 +0000
Message-ID: <CH0PR12MB5348CA39DC370EEDE3817C99973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-4-Graham.Sider@amd.com>
 <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB30676D0E36B54D85296A685F8A3C9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CH0PR12MB53480D82E2D1C8EF998760F4973C9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <DM6PR12MB26197ADDF59681FD0902780DE43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197ADDF59681FD0902780DE43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T04:51:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1160a2c4-c7ad-40a2-846e-0d6c59d370a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:158d:ec71:65c6:5505:11d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7d9a8b3-866b-4b03-bcf0-08d927147885
x-ms-traffictypediagnostic: CH0PR12MB5075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB507532DBC124BF408C0D1310973B9@CH0PR12MB5075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdjMSxmpdXtMI08Q5ygMRDn23izssBa2gg2I/WfPtxg85mYk7oSCTNcRuEVlmyjWixEZWYh/TxD9aBDmjhRJfqOYXu25nIHOHW8ZJbZQ6iqM3AkTlOZaKWJlV23GI1r3+5L6IayGzlKiSVi/TzXweCafgVP+GevPd2iYuDjb736m3zkpSkA4tkYA3O0hACQtZGe+fmMwqpMJvmVmtCrV3v7kOl1oklePxe7Je2nrtsgSQ1CYNiuQYIueZFFHCKb4Uj36pwyoEivOIleQq9SFJKz+EHLOXLb8Ris8gv3ev2EoN3th89bzx2yxvVP0FWc1ZvJFjV2v5Qd0nUAQq7nQB6p8YVMSZdSb69CMZ8G58jUHNsycYA5LYVKmscB8+1+2IlvvVCu0sym8B9yRBlJL2sN0NQLGhE1siEnoJjoATxH9NcgGxIdnAkiDmva6VNkRrHwEfaJ0NY1OkZ2GCBvVKyyO+M1W+5sGY0YZVvY2aDKAstIuYwi1wtIRiu04wnrPXmo7y71pg5S2n3HvDoOoxT99nHQT8c3l5unqPUSGOLoz3UGyh07muTvHgrRXLs2AcEKJhX4gX9RN1cs978EYxV0Sqz6BA1gTo1pLcC0xZaFsGknJUfYIA5DsVJeQf3CbpH/NMC1ui84dqtEm+vOpgkZCY9sUZqkZZdiKRBSSJYJDP4o2/kdU52JYA/GoZVSK3G1qAEXapleRzYnj66i3aQK78Z941bw77xS/hcBTHPW6TpeB6ouMGy69KsRgjLuwlx1LDrm1zaZqqi/xvas5c0vnTK28fuRzigLlPLAQ+kI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(54906003)(110136005)(316002)(76116006)(9686003)(71200400001)(55016002)(2906002)(8676002)(8936002)(86362001)(52536014)(66556008)(6506007)(5660300002)(122000001)(83380400001)(38100700002)(66446008)(186003)(66946007)(64756008)(7696005)(45080400002)(478600001)(66476007)(53546011)(33656002)(4326008)(966005)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?40+E0heiwgWO+VK9jsAeHCFbih8vFFBgsZ90N0DdfckdByVwcbd2OPUGSTXr?=
 =?us-ascii?Q?1rFn8imyITffY9AtfpH27fx59XLje/8ACJjicbC3bzkMRKBK9EL7hx/hysfv?=
 =?us-ascii?Q?DiPOkT76vOBZ9+WO5k9lRLGEG9DlFiigoTMD2LVC182N59fSYulK0YCbNnHx?=
 =?us-ascii?Q?Xrc0EyB9gTU1YdMkc8BgchSx0tP9Qswhea86SixZ/Qa8hhZnUEzxki7GqSc9?=
 =?us-ascii?Q?FmqgKNO/LzXkgxVgllyTmDFie+28bWB9a7yZum+8jSgPXHBQyvw67kdHEhdl?=
 =?us-ascii?Q?EfKsO1PExSnmkxW5N2WJoUBUSfV9n0p+a5JjgR0gqCHGWQhNXtuJEfjd1GxP?=
 =?us-ascii?Q?wtwQX9O6z0q5yQzyneYAl1vM9KLa3KOAchBexiEMcNLDRHwxJ0apEpv9KZtr?=
 =?us-ascii?Q?/l/8HVrSOM6r51EqdyW5aDReUGUT50dhRH8LF/K6YzXXWb/Fz8fZhXU3zBzo?=
 =?us-ascii?Q?AvmlQsSwXBolgR3/eXMzK6yg8Nzjm/aG4/93jVI/P591pIEhOw6uJhbJdBW7?=
 =?us-ascii?Q?VUIUAHd57fG83CPltdJIc2FO4ysDqh0uaSAHkxhV1tI9OPiNBiUDkVk4yX3e?=
 =?us-ascii?Q?kWyK/kytD11Yt7tSkUtY2ltmmhCaXVdjs6Ze6Z2Yw7Cuz9IWU/GrSylFSA/r?=
 =?us-ascii?Q?nHN2ohX2mJV3z4bB1BeEih+uqUQ4QGNebQJ/E/k3+u4zSR+p9VxFLsEYrdVc?=
 =?us-ascii?Q?1lWzlUfJIR6sWVrKtDpXEtVdjtbiOSE7lji6aWMV04iwTaXvF1AG6HCulf5K?=
 =?us-ascii?Q?V3YH1GUFUB0oKBL4/kv+v6w9aiTAi3QQZBhhiDAAQDA/VE42IUXMFKf90XkC?=
 =?us-ascii?Q?PtEs3zYEvKdbwXFg/ix5/GS20NM/VweXTYbfHOoZRg/y0jx30T43nQHYVbWu?=
 =?us-ascii?Q?aArL31n/nB2MncsviBfT758CBz4m08ZXVDShHNW67LwJJu2Y7ThPSRfMgeIO?=
 =?us-ascii?Q?mPmYlXiiPxLQIugHca8HlzfCo+KIODtc9B9LpmKuM1GYNoT8jj1XWr3H45g6?=
 =?us-ascii?Q?80QsURv/SjxvuRM5zGT+0DqHl8rF8uFFw+nkyblP+HX3cwfuks/ejDMMO8av?=
 =?us-ascii?Q?beh5jbuxm3JgX7kRnBMPJj9TWdGYT4ggF0Xl7LGp66/IU0vs/0kRcpCw3Bn2?=
 =?us-ascii?Q?cwj5UgAjXtZS1Uy4AOZQld7hXxEMLwCefUbF7wccYlsPKTInpcfG98TNbmei?=
 =?us-ascii?Q?RgFEDwx90wey+RqszsZAt5m7nOZ2eKc+uvO3OrUq3xsJMVH7RbQQBIaFNYfg?=
 =?us-ascii?Q?4Y6MGcO8x4Yr3+ppYk5ihsHfyalxH7Q0DZ2CsMfoHIn1PKyRGo7XOJ0B6KGU?=
 =?us-ascii?Q?h94sBZ2rQpmqSGYFx9IiCUm3moxE/DN/vWLf6T0SiJ1YdRNpVBtZVIrJr9K0?=
 =?us-ascii?Q?wti3BKfWFEcQUt/ZwMYc8WBNCIka?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d9a8b3-866b-4b03-bcf0-08d927147885
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 04:51:52.2464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sn6efdGP7v4MOIIsQ1/7cenVsUFYLKLiLiWOnLHG8P4BKzskN1HaQy1oKAtoOjbF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

A modified version of 2  -  
	List all the possible ones and merge those which mean the same - ex: terminology changes like THM and TEMP.

In the mail earlier, I meant to list them out separately as the intention is to convey the throttle reason to the user- it's better to point out the exact regulator which is heating up. 

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Friday, June 4, 2021 7:47 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation

[AMD Official Use Only]

Thanks Lijo and Graham. Yes, I know that only some specific ASICs support VR_MEM1 and LIQUID1.
However, the problem is about the design:
1. should we just list those which are commonly supported by all ASICs.
2. Or we list all the possible throttlers and mask out those unsupported for some specific ASICs

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, June 3, 2021 10:01 PM
> To: Sider, Graham <Graham.Sider@amd.com>; Quan, Evan 
> <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; 
> Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler 
> translation
> 
> [AMD Official Use Only]
> 
> VR_*0/1 reflect the throttle status of separate voltage rails - 
> availability of both depends on board and FW capability to query their temperature.
> 
> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: Thursday, June 3, 2021 6:41 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler 
> translation
> 
> Some ASICs use a single VR_MEM bit, whereas others split it into 
> VR_MEM0 and VR_MEM1. To avoid confusion, we've combined the VR_MEM0 
> and
> VR_MEM1 bits on those ASICs. For consistency we did the same with
> LIQUID0 and LIQUID1.
> 
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Wednesday, June 2, 2021 12:37 AM
> To: Sider, Graham <Graham.Sider@amd.com>; amd- 
> gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>; Sider, Graham 
> <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler 
> translation
> 
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> > Graham Sider
> > Sent: Wednesday, June 2, 2021 2:12 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> > <Harish.Kasiviswanathan@amd.com>; Sider, Graham 
> > <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) 
> > <Elena.Sakhnovitch@amd.com>
> > Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> >
> > Perform dependent to independent throttle status translation for 
> > navi1x. Makes use of lookup table navi1x_throttler_map.
> >
> > Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43
> > +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 78fe13183e8b..bf376b1be08d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -238,6 +238,28 @@ static struct cmn2asic_mapping 
> > navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
> >  	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> > 	WORKLOAD_PPLIB_CUSTOM_BIT),
> >  };
> >
> > +static const uint8_t navi1x_throttler_map[] = {
> > +	[THROTTLER_TEMP_EDGE_BIT]	=
> > (SMU_THROTTLER_TEMP_EDGE_BIT),
> > +	[THROTTLER_TEMP_HOTSPOT_BIT]	=
> > (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> > +	[THROTTLER_TEMP_MEM_BIT]	=
> > (SMU_THROTTLER_TEMP_MEM_BIT),
> > +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> > +	[THROTTLER_TEMP_VR_MEM0_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> > +	[THROTTLER_TEMP_VR_MEM1_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> [Quan, Evan] I'm wondering why you map the two ASIC dependent bits to 
> the same non ASIC independent bit. Instead of defining two non ASIC 
> independent bits.
> > +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> > +	[THROTTLER_TEMP_LIQUID0_BIT]	=
> > (SMU_THROTTLER_TEMP_LIQUID_BIT),
> > +	[THROTTLER_TEMP_LIQUID1_BIT]	=
> > (SMU_THROTTLER_TEMP_LIQUID_BIT),
> [Quan, Evan] Same question here and for Patch4.
> 
> BR
> Evan
> > +	[THROTTLER_TDC_GFX_BIT]		=
> > (SMU_THROTTLER_TDC_GFX_BIT),
> > +	[THROTTLER_TDC_SOC_BIT]		=
> > (SMU_THROTTLER_TDC_SOC_BIT),
> > +	[THROTTLER_PPT0_BIT]		=
> > (SMU_THROTTLER_PPT0_BIT),
> > +	[THROTTLER_PPT1_BIT]		=
> > (SMU_THROTTLER_PPT1_BIT),
> > +	[THROTTLER_PPT2_BIT]		=
> > (SMU_THROTTLER_PPT2_BIT),
> > +	[THROTTLER_PPT3_BIT]		=
> > (SMU_THROTTLER_PPT3_BIT),
> > +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> > +	[THROTTLER_PPM_BIT]		=
> > (SMU_THROTTLER_PPM_BIT),
> > +	[THROTTLER_APCC_BIT]		=
> > (SMU_THROTTLER_APCC_BIT),
> > +};
> > +
> > +
> >  static bool is_asic_secure(struct smu_context *smu)  {
> >  	struct amdgpu_device *adev = smu->adev; @@ -524,6 +546,19 @@
> static
> > int navi10_tables_init(struct smu_context
> > *smu)
> >  	return -ENOMEM;
> >  }
> >
> > +static uint64_t navi1x_get_indep_throttler_status(
> > +					const unsigned long dep_status) {
> > +	uint64_t indep_status = 0;
> > +	uint8_t dep_bit = 0;
> > +
> > +	for_each_set_bit(dep_bit, &dep_status, 32)
> > +		indep_status |= smu_u64_throttler_bit(dep_status,
> > +			navi1x_throttler_map[dep_bit], dep_bit);
> > +
> > +	return indep_status;
> > +}
> > +
> >  static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
> >  					      MetricsMember_t member,
> >  					      uint32_t *value)
> > @@ -2673,6 +2708,8 @@ static ssize_t 
> > navi10_get_legacy_gpu_metrics(struct smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct 
> > smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2826,6 +2865,8 @@ static ssize_t 
> > navi12_get_legacy_gpu_metrics(struct smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct 
> > smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> > freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf05ba28afbe0417ac
> >
> 54008d925290dc0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> >
> 7581680520671680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> >
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> >
> PzZzTHlRh0ygXIJdQeN8%2Ff4ojC9KcCy4Ia5POPGw1nI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
