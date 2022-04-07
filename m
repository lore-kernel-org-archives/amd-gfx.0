Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 16:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B674B10EBAB;
	Thu,  7 Apr 2022 16:33:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B8F10EBAB
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 16:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j56zxWCZas3L7Lw69EyMh+4TeSbCb+qhGsGqqn5KnvcgK+5OjPeMerZUJE6Vgq2bBPZhDvOeYfDodyidO4+rd8hq8syDSWSqSP6pItVXlMovTnY425+1Xa6Cecnk7krbgKRopYC/AD87TzeRWCoY9oPSyAlPNncIHS1++luRaN94LIOGrlEeimPHm1p1gwm09ccI6NkjapuVVTSotbOBF2nxwQcOx6pUrhwW8LIbljx6T/D/zE0gJwZQnpe1cisfQIS7/1dV/T7NAxZhf6uwk/9N/0IsyZ26nKrZ7dwKhqnLTagrASihnRfC3pofpZeXcgGepzLexFRuWze5jYUzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwKOqnIz2qAnElo3a2b5TZW3FHtsJCGzI8rlVDyxtQ0=;
 b=QWqiG5Ij0Du2YdqWsTqudeexWELzvFdE2yT+ecr/WPaNuAjVhBDAcCqf7R3XnTbcr+u3JFSBwbIWirZ+jqYUj36k730K+aOHeZPxG/cgAldEVhpWQ30nODWPuQUNxDXwjfyVNIUJMsiyEaNUgrNA65Vidhmtepm/+dAsQblCRxX5DLahDKeVWq9T052DVpxrcVnZfaIKH0BgHP5Xhe+s7RTt687SoP7Hn47kEggc7C42n7f8G5BQ0JEtVSKy0MJxGZDXW1j8oC2NOV8+fo2jF7ddsPSN8BTynpnJolXxRMlZ4rhFFZRnJ7bMSEodxeFBvSpZfQAtAd5mPqPCK/oONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwKOqnIz2qAnElo3a2b5TZW3FHtsJCGzI8rlVDyxtQ0=;
 b=23SFyRCTZM5t33squLcYpVzLEgC8tIV7NZ+EXP9BUgqrU5fGE4eS/ECfm5Z8PrVitrCXstIkyyfw6I5vkVRP9nFGPaKe8cdGk+Ov7+9wPA5FXnIAOY7Q2CxAZuUKx7GyzBvtXioznQramRCPN4uew4e0RvDTov6tJX8wyzSn2Mc=
Received: from DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14)
 by BN9PR12MB5276.namprd12.prod.outlook.com (2603:10b6:408:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 16:33:07 +0000
Received: from DM5PR12MB1786.namprd12.prod.outlook.com
 ([fe80::c834:f82a:2d77:a83a]) by DM5PR12MB1786.namprd12.prod.outlook.com
 ([fe80::c834:f82a:2d77:a83a%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 16:33:07 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: Shuotao Xu <shuotaoxu@microsoft.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Topic: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Index: AQHYSV+lQh0DehaAkU6mUF/D9OJf/qzi7iYAgAABCGOAAAWHAIAAAhPygACboOCAAPv2GoAAFV4ggAABxCqAAAGEIA==
Date: Thu, 7 Apr 2022 16:33:07 +0000
Message-ID: <DM5PR12MB178632D54A66F1B7DA7A370FEEE69@DM5PR12MB1786.namprd12.prod.outlook.com>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
 <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <990573e7-bc0e-0c3a-11b9-c725fdee44df@amd.com>
 <PSAP153MB05176F6C82945DE2C3443248B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <DM5PR12MB1786CA4217F5A00B4CF706AAEEE69@DM5PR12MB1786.namprd12.prod.outlook.com>
 <PSAP153MB0517AFB4B9CF54A17CD5223EB7E69@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <DM5PR12MB1786800FB516F8E518A4FB6EEEE69@DM5PR12MB1786.namprd12.prod.outlook.com>
 <PSAP153MB05173E5FCB36EBC7054695DCB7E69@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PSAP153MB05173E5FCB36EBC7054695DCB7E69@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-07T16:33:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b555541a-ac78-412e-83ad-4331447b0fa4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa9958b2-4b02-4f11-13a8-08da18b44c46
x-ms-traffictypediagnostic: BN9PR12MB5276:EE_
x-microsoft-antispam-prvs: <BN9PR12MB527648B2481E78B45035D37BEEE69@BN9PR12MB5276.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vwv1KUB5yuNaGIm0zF4oFCGNWytRaGvqk7aD0tR9DnxgVw+AvSZcpjfnwtFgsq0Jj3RtE6WZ1Fl27rOqvqYq2YimcZwNYgOfp2oONv7sezH7Fk3Lxnww7WQeCk2gaRp374i2x573XbFfIFPyFwvbX4ooyA7vIvwH9BC2UJ2nf6VU0vLhODp7E/XKfT2mV5IndBb/YdcHvj1BZ9XOkCTq+SeIMbaPQ37Lmg+Kmjob7jAi9ZGOmIV1scz6Y8J7w07xEwN+mF2p/tWPCvYovJ5iQQgssMBRre6ATAydYLfiO2gKpVxmWNgAbzInx3rIj5Dul+OFYTVc2Zwp1NpF2rRVnmX/OtkTyCMH+XoZkZUYwFYUnuulMunbUOyWezfw4H75+FT9QKnU+aLMn0aAa/qIe9A+hV/imMKiO9zK2uMqZzLyPWPmTE544jZ+V2pej4QBSK6nw97QmILCy8Xc9jgij2HN730dWRVHx/ixW4PHVTWa0DvLikf9dqxvzX5ODOgQTjYpPJlfUQKbKbGHrB1gsf3GOqNnnORxL1iByuzJjFsu4l4QhCh6VBMkdOf62rQXD81RHTjPHU0UpUCG215brq0DolHC/5MBTS0cHfSPjqfgSIOj/V40xsJfGEsc5q3D7R2DDOOlRikEoFmoREpBSjlwpxj3i9zKTwEvE/bNjta83l0EImHxcRQUkdBt7yo/h/exngf0yRClZ98P47ONkxc0DudTCVoA+UHmMieMWS1XX+w5z2qEYT6I1Ot0Jec612pyZEmS02QsQmnReFvb3SG3Zbz9j903SXGYjgb1MvgT3tRZldfb7EZx75DbwY7LAcOEED7njVQyraHNIbawIBX9xjGoQcWQrphfPzTach0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1786.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(66446008)(64756008)(66946007)(122000001)(66556008)(2906002)(8676002)(4326008)(76116006)(508600001)(38100700002)(110136005)(55016003)(83380400001)(71200400001)(7696005)(45080400002)(966005)(53546011)(9686003)(16799955002)(6506007)(33656002)(26005)(186003)(5660300002)(38070700005)(54906003)(86362001)(8936002)(52536014)(166002)(316002)(30864003)(559001)(579004)(10090945011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bw82N9O7QjVd7FOZm/9Iy5ude41gvfViW4hUriaTFjJ3llcQcwKlpTJnPT2g?=
 =?us-ascii?Q?//8if1XKnjnT+Ok30cluWyGxe2jAMKEYUIOHYAxZJzmIrJw9kFTyhx2/ECuH?=
 =?us-ascii?Q?hzBEZBwGs17HdiSuelIpEMXcuFmFDzaTanXTZYzVOEBRGhwG5Z/6fNgd75vB?=
 =?us-ascii?Q?I2X73WpRVTSxwCnQh0zF2+p2Yv99W0z9pmEw2a3zau3spXeGa0NLUQ2iGQ1Y?=
 =?us-ascii?Q?NNdTZMwFA9edhdBlG/hUVKZxoksMJRUi17qkJTo/hG7RRQrZry0Kp+IbMrIZ?=
 =?us-ascii?Q?GJwRZjiaRgUXy2Mm0Aob1GbffFdbYtHX1+XudB+D5A4CfPMq60M1HSkE8HeO?=
 =?us-ascii?Q?xdt45PT01W9GuXBJwc2jsKwLHlX2ITzK+aF/mzDPTD/EAVUTteRXlQ/Us4ht?=
 =?us-ascii?Q?GOr1XMGDm1vB3McxeHCl3TQG6Me84H0IhEx2dBdbqKByyTjf+TBjX75W8CTN?=
 =?us-ascii?Q?TwLr8ZK8jfLCMPN32rF4d+NU1ihX0V6NJ0bkHwO/LGz/caWSH2Y86K0cWH1i?=
 =?us-ascii?Q?D1F96FuVCPFjSH5cyTUmgcXo0ZpojMwxxwwBHes3i2phgsS2zqv1Mym4Rmij?=
 =?us-ascii?Q?yw91q9PgCSq9qNahkpYnfKOxLWLJTMZoW08KfyT7TBoD4GHcjmRydMDB/HMo?=
 =?us-ascii?Q?wQ0AWrSv9zqfkfIMhlC4+mbSsbWPjy6RJ9RMkVnWyL4wdyWIvx298qoPZwIy?=
 =?us-ascii?Q?tm1uAoTpCpjFjSphD7gFRUHb1RtvQ27Dp/Vhnj+QQtISHmLvE2NoizNyy83m?=
 =?us-ascii?Q?TVq5n2B3XEU5kIMlZ8Lbsi/HwpUrkSJINUQBJ6mpmfwZCoOrQmRMDdCdTYwR?=
 =?us-ascii?Q?RoG+ev48M0v3XMFpUM2/2fBMo7jDK3aFRjnl3DODLCXmD+iTHYVRJL0OA2AA?=
 =?us-ascii?Q?WMrRuEZEbbCfulsAlXgAkSo0Do5xBFo8mHcZ7Mlh5h5Jmrj5ggvzMl2TXg/S?=
 =?us-ascii?Q?yZFZ8DwgJM9KDN5dwkx+CkIum+2JC8y6/MioLBPIOok2FSjm+P/3ngrN7RQe?=
 =?us-ascii?Q?HrsIFvAezFCJi0YDxPZ9X20eKHRoL/fPgFPbANru8bMPcoO6jjAosYH5089w?=
 =?us-ascii?Q?aijz0tI1IgTkNHndGPqsp2GmjcykWPa51NO7CsVrEo3ltAJNWbM0LK2e0jmw?=
 =?us-ascii?Q?sdV+YkZFGnnma9yIfjA4FCagFis+Byhn/cyVT2jGfZ+iiB+quilWoUvRW90C?=
 =?us-ascii?Q?gbUPs9ewAAMuVAW/+goktjjW0xtLtTwmIV0sp0/qRvAGNVFhU7afBy7pX0Ik?=
 =?us-ascii?Q?fV5F5YPkBy5D0aehDF3IfuLlFRSUFai0uvPMx4gMdfbYv9CI3KfJ3hDK0X0H?=
 =?us-ascii?Q?8auqh/TxE9KyxnO+m/NrYP13k9iOXU1JicWuXloOeFS7X+Sn4M1QNsn5gJTJ?=
 =?us-ascii?Q?rwZDRPTdMPFE5NUi75ahPo3FffjkxTumw14oiVU5SEVg2+F5rqhzwZRIrO3H?=
 =?us-ascii?Q?Xg8IbCrQGmlb5ytMWIdcOxYgZRuqFEu0yb2Bpcanq50Ti95WecgniUvDqHZP?=
 =?us-ascii?Q?tLJzKP/gY2cC9Jz2OF9J+2iLAZMY8TSBSE8fEP+lkNCX5S5rc8CwTD+nHMM5?=
 =?us-ascii?Q?k2oPSnCczxwUk8+LDLKQNBBRpChSDY7tYYyO0SeogdVWwFrk4PpnA5FvkgJt?=
 =?us-ascii?Q?k/T36+OROaTfUmq7pJ60eai8CmANCm5zSyROAorxrY8Y6tftwO4vnvE2ZZb6?=
 =?us-ascii?Q?VkuPLrQvyVfB0MyNkUnezEECXu9A0NOD0D+egpbGBfqVutojJsrd86/6pkOP?=
 =?us-ascii?Q?3IsYcFQzgw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB178632D54A66F1B7DA7A370FEEE69DM5PR12MB1786namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1786.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9958b2-4b02-4f11-13a8-08da18b44c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 16:33:07.8562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SfS6cCyjTmQrX/YLzyoVD1s8LVY8QvzY+ycugWpwZ4ArkTWBOtof5I/MxgdaZehwQJdfs7ksQoJZsiYBj9OoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB178632D54A66F1B7DA7A370FEEE69DM5PR12MB1786namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks Shuotao.
If the IO link cleanup works ok for you, you can use this patch as the base=
 for adding your changes to add Hot Plug support. You can send a separate p=
atch for that.

Regards,
Mukul

From: Shuotao Xu <shuotaoxu@microsoft.com>
Sent: Thursday, April 7, 2022 12:28 PM
To: Joshi, Mukul <Mukul.Joshi@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovs=
ky@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>; Lei Qu <Lei.Qu@microsoft.com>; P=
eng Cheng <pengc@microsoft.com>; Ran Shu <Ran.Shu@microsoft.com>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support

[CAUTION: External Email]
Thanks Mukul very much!

The code looks neat, although kfd_locked looks still would cause trouble. I=
 will try it.

Best,
Shuotao

From: Joshi, Mukul <Mukul.Joshi@amd.com<mailto:Mukul.Joshi@amd.com>>
Date: Friday, April 8, 2022 at 12:23 AM
To: Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>>, G=
rodzovsky, Andrey <Andrey.Grodzovsky@amd.com<mailto:Andrey.Grodzovsky@amd.c=
om>>, amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <=
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.com>>,=
 Lei Qu <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>, Peng Cheng <pe=
ngc@microsoft.com<mailto:pengc@microsoft.com>>, Ran Shu <Ran.Shu@microsoft.=
com<mailto:Ran.Shu@microsoft.com>>
Subject: RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support

[AMD Official Use Only]

Hi Shuotao,

Just sent out the patch to cleanup IO links upon KFD device removal to the =
public mailing list.
Please try it, review it and let us know how it goes for you.

Thank you.

Regards,
Mukul

From: Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>>
Sent: Thursday, April 7, 2022 11:09 AM
To: Joshi, Mukul <Mukul.Joshi@amd.com<mailto:Mukul.Joshi@amd.com>>; Grodzov=
sky, Andrey <Andrey.Grodzovsky@amd.com<mailto:Andrey.Grodzovsky@amd.com>>; =
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.com>>;=
 Lei Qu <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>; Peng Cheng <pe=
ngc@microsoft.com<mailto:pengc@microsoft.com>>; Ran Shu <Ran.Shu@microsoft.=
com<mailto:Ran.Shu@microsoft.com>>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support

[CAUTION: External Email]
Hi Joshi,

Per your comment, I produced a fix to work with multi-GPU system for hotplu=
g support for our group's internal usage.

I have tested on a 4-node MI100 system, which seems to be working. It is pu=
shed in the github PR.
The details are in: https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver=
/pull/131#issuecomment-1091843803<https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Dri=
ver%2Fpull%2F131%23issuecomment-1091843803&data=3D04%7C01%7CMukul.Joshi%40a=
md.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3DyGHto9N07npET=
zwdiPitfQF4J0NZFuKBdD%2FZQ8NpwJM%3D&reserved=3D0>

I will send the patch to the mail-list also.

May I know when your patch is ready for public review?

All the best,
Shuotao


From: Joshi, Mukul <Mukul.Joshi@amd.com<mailto:Mukul.Joshi@amd.com>>
Date: Thursday, April 7, 2022 at 10:24 AM
To: Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>>, G=
rodzovsky, Andrey <Andrey.Grodzovsky@amd.com<mailto:Andrey.Grodzovsky@amd.c=
om>>, amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <=
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.com>>,=
 Lei Qu <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>, Peng Cheng <pe=
ngc@microsoft.com<mailto:pengc@microsoft.com>>, Ran Shu <Ran.Shu@microsoft.=
com<mailto:Ran.Shu@microsoft.com>>
Subject: RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
You don't often get email from mukul.joshi@amd.com<mailto:mukul.joshi@amd.c=
om>. Learn why this is important<http://aka.ms/LearnAboutSenderIdentificati=
on>

[AMD Official Use Only]

Hi Shuotao,

Thanks for your patch.
I have been working on something similar as I also found that we don't clea=
nup IO links upon device removal.

The IO-links cleanup change in your patch would work only either on a singl=
e GPU system or a multi-GPU system where the last node (in the sysfs topolo=
gy) is hot-plugged out. That's because of the way the atomic counter, topol=
ogy_crat_proximity_domain, is used in the code.

I have a patch which takes care of these issues on a multi-GPU system.
I should be able to send that out for review in sometime.

Thanks,
Mukul

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Shuotao Xu
Sent: Wednesday, April 6, 2022 11:12 AM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com<mailto:Andrey.Grodzovsky@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.com>>;=
 Lei Qu <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>; Peng Cheng <pe=
ngc@microsoft.com<mailto:pengc@microsoft.com>>; Ran Shu <Ran.Shu@microsoft.=
com<mailto:Ran.Shu@microsoft.com>>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support

[CAUTION: External Email]
Hi Andrey,

Thanks for your kind comment on linux patch submission protocol, please let=
 me know if there is anyway to rectify it.

dmesg is fine except with some warning during pci rescan after pci removal =
of an AMD MI100.

The issue is that after this rocm application will return segfault with the=
 amdgpu driver unless the entire amdgpu kernel module is unloaded and loade=
d, which we did not meet our hotplug requirement. The issues upon investiga=
tion are
1) kfd_lock is locked after hotplug, and kfd_open will return fault right a=
way to libhsakmt .
2) iolink/p2plink has anormalies after hotplug, and libhsakmt will found su=
ch anomalies and return error.

Our patch has been tested with a single-instance AMD MI100 GPU and showed i=
t worked.

I am attaching the dmesg after rescan anyway, which will show the warning a=
nd the segfault.

[  132.054822] pci 0000:43:00.0: [1002:738c] type 00 class 0x038000
[  132.054856] pci 0000:43:00.0: reg 0x10: [mem 0x38b000000000-0x38b7ffffff=
ff 64bit pref]
[  132.054877] pci 0000:43:00.0: reg 0x18: [mem 0x38b800000000-0x38b8001fff=
ff 64bit pref]
[  132.054890] pci 0000:43:00.0: reg 0x20: [io  0xa000-0xa0ff]
[  132.054904] pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]
[  132.054918] pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]
[  132.055134] pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold
[  132.055217] pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[  132.056001] pci 0000:43:00.0: Adding to iommu group 73
[  132.057943] pci 0000:43:00.0: BAR 0: assigned [mem 0x38b000000000-0x38b7=
ffffffff 64bit pref]
[  132.057960] pci 0000:43:00.0: BAR 2: assigned [mem 0x38b800000000-0x38b8=
001fffff 64bit pref]
[  132.057974] pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff=
]
[  132.057981] pci 0000:43:00.0: BAR 6: assigned [mem 0xb8480000-0xb849ffff=
 pref]
[  132.057984] pci 0000:43:00.0: BAR 4: assigned [io  0xa000-0xa0ff]

[  132.058429] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  132.058453] WARNING: possible circular locking dependency detected
[  132.058477] 5.16.0-kfd+ #1 Not tainted
[  132.058492] ------------------------------------------------------
[  132.058515] bash/3632 is trying to acquire lock:
[  132.058534] ffffadee20adfb50 ((work_completion)(&wfc.work)){+.+.}-{0:0},=
 at: __flush_work+0x2f5/0x470
[  132.058554] [drm] initializing kernel modesetting (ARCTURUS 0x1002:0x738=
C 0x1002:0x0C34 0x01).
[  132.058577]
               but task is already holding lock:
[  132.058580] ffffffffa3c62308
[  132.058630] amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re not supported
[  132.058638]  (
[  132.058678] [drm] register mmio base: 0xB8400000
[  132.058683] pci_rescan_remove_lock
[  132.058694] [drm] register mmio size: 524288
[  132.058713] ){+.+.}-{3:3}, at: rescan_store+0x55/0x90
[  132.058773]
               which lock already depends on the new lock.

[  132.058804]
               the existing dependency chain (in reverse order) is:
[  132.058819] [drm] add ip block number 0 <soc15_common>
[  132.058831]
               -> #1 (
[  132.058854] [drm] add ip block number 1 <gmc_v9_0>
[  132.058858] [drm] add ip block number 2 <vega20_ih>
[  132.058874] pci_rescan_remove_lock
[  132.058894] [drm] add ip block number 3 <psp>
[  132.058915] ){+.+.}-{3:3}
[  132.058931] [drm] add ip block number 4 <smu>
[  132.058951] :
[  132.058965] [drm] add ip block number 5 <gfx_v9_0>
[  132.058986]        __mutex_lock+0xa4/0x990
[  132.058996] [drm] add ip block number 6 <sdma_v4_0>
[  132.059016]        i801_add_tco_spt.isra.20+0x2a/0x1a0
[  132.059033] [drm] add ip block number 7 <vcn_v2_5>
[  132.059054]        i801_add_tco+0xf6/0x110
[  132.059075] [drm] add ip block number 8 <jpeg_v2_5>
[  132.059096]        i801_probe+0x402/0x860
[  132.059151]        local_pci_probe+0x40/0x90
[  132.059170]        work_for_cpu_fn+0x10/0x20
[  132.059189]        process_one_work+0x2a4/0x640
[  132.059208]        worker_thread+0x228/0x3f0
[  132.059227]        kthread+0x16d/0x1a0
[  132.059795]        ret_from_fork+0x1f/0x30
[  132.060337]
               -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[  132.061405]        __lock_acquire+0x1552/0x1ac0
[  132.061950]        lock_acquire+0x26c/0x300
[  132.062484]        __flush_work+0x315/0x470
[  132.063009]        work_on_cpu+0x98/0xc0
[  132.063526]        pci_device_probe+0x1bc/0x1d0
[  132.064036]        really_probe+0x102/0x450
[  132.064532]        __driver_probe_device+0x100/0x170
[  132.065020]        driver_probe_device+0x1f/0xa0
[  132.065497]        __device_attach_driver+0x6b/0xe0
[  132.065975]        bus_for_each_drv+0x6a/0xb0
[  132.066449]        __device_attach+0xe2/0x160
[  132.066912]        pci_bus_add_device+0x4a/0x80
[  132.067365]        pci_bus_add_devices+0x2c/0x70
[  132.067812]        pci_bus_add_devices+0x65/0x70
[  132.068253]        pci_bus_add_devices+0x65/0x70
[  132.068688]        pci_bus_add_devices+0x65/0x70
[  132.068936] amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR
[  132.069109]        pci_bus_add_devices+0x65/0x70
[  132.069602] amdgpu: ATOM BIOS: 113-D3431401-X00
[  132.070058]        pci_bus_add_devices+0x65/0x70
[  132.070572] [drm] VCN(0) decode is enabled in VM mode
[  132.070997]        pci_rescan_bus+0x23/0x30
[  132.071000]        rescan_store+0x61/0x90
[  132.071003]        kernfs_fop_write_iter+0x132/0x1b0
[  132.071501] [drm] VCN(1) decode is enabled in VM mode
[  132.071964]        new_sync_write+0x11f/0x1b0
[  132.072432] [drm] VCN(0) encode is enabled in VM mode
[  132.072900]        vfs_write+0x35b/0x3b0
[  132.073376] [drm] VCN(1) encode is enabled in VM mode
[  132.073847]        ksys_write+0xa7/0xe0
[  132.074335] [drm] JPEG(0) JPEG decode is enabled in VM mode
[  132.074803]        do_syscall_64+0x34/0x80
[  132.074808]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  132.074811]
               other info that might help us debug this:

[  132.074813]  Possible unsafe locking scenario:

[  132.075302] [drm] JPEG(1) JPEG decode is enabled in VM mode
[  132.075779]        CPU0                    CPU1
[  132.076361] amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.
[  132.076765]        ----                    ----
[  132.077265] amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.
[  132.078649]   lock(pci_rescan_remove_lock);
[  132.078652]                                lock((work_completion)(&wfc.w=
ork));
[  132.078653]                                lock(pci_rescan_remove_lock);
[  132.078655]   lock((work_completion)(&wfc.work));
[  132.078656]
                *** DEADLOCK ***

[  132.078656] 5 locks held by bash/3632:
[  132.078658]  #0: ffff9c39c7b89438
[  132.079612] amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized succe=
ssfully, hardware ability[7fff] ras_mask[7fff]
[  132.080089]  (
[  132.080602] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[  132.081082] sb_writers
[  132.081601] amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 0x0000008000000000=
 - 0x00000087FEFFFFFF (32752M used)
[  132.082102] #6
[  132.082630] amdgpu 0000:43:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[  132.083152] ){.+.+}-{0:0}
[  132.083687] amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 0x0000008800000=
000 - 0x0000FFFFFFFFFFFF
[  132.084210] , at: ksys_write+0xa7/0xe0
[  132.085708] [drm] Detected VRAM RAM=3D32752M, BAR=3D32768M
[  132.086205]  #1:
[  132.086733] [drm] RAM width 4096bits HBM
[  132.087269] ffff9c5959011088
[  132.087890] [drm] amdgpu: 32752M of VRAM memory ready
[  132.088389]  (
[  132.088972] [drm] amdgpu: 32752M of GTT memory ready.
[  132.089572] &of->mutex
[  132.090206] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  132.090804] ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0
[  132.090808]  #2: ffff9c39c882a9e0 (kn->active#423){.+.+}-{0:0}, at: kern=
fs_fop_write_iter+0x10c/0x1b0
[  132.091639] [drm] PCIE GART of 512M enabled.
[  132.092117]  #3:
[  132.092801] [drm] PTB located at 0x0000008000000000
[  132.093480] ffffffffa3c62308
[  132.094566] amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't ex=
ist
[  132.094822]  (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x55=
/0x90
[  132.094827]  #4: ffff9c597392b248 (&dev->mutex){....}-{3:3}, at: __devic=
e_attach+0x39/0x160
[  132.094835]
               stack backtrace:
[  132.097098] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revi=
sion: 21
[  132.097467] CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1
[  132.098169] amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[  132.098839] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIO=
S 2.1 08/14/2018
[  132.098841] Call Trace:
[  132.098842]  <TASK>
[  132.098843]  dump_stack_lvl+0x44/0x57
[  132.098848]  check_noncircular+0x105/0x120
[  132.098853]  ? unwind_get_return_address+0x1b/0x30
[  132.112924]  ? register_lock_class+0x46/0x780
[  132.113630]  ? __lock_acquire+0x1552/0x1ac0
[  132.114342]  __lock_acquire+0x1552/0x1ac0
[  132.115050]  lock_acquire+0x26c/0x300
[  132.115755]  ? __flush_work+0x2f5/0x470
[  132.116460]  ? lock_is_held_type+0xdf/0x130
[  132.117177]  __flush_work+0x315/0x470
[  132.117890]  ? __flush_work+0x2f5/0x470
[  132.118604]  ? lock_is_held_type+0xdf/0x130
[  132.119305]  ? mark_held_locks+0x49/0x70
[  132.119981]  ? queue_work_on+0x2f/0x70
[  132.120645]  ? lockdep_hardirqs_on+0x79/0x100
[  132.121300]  work_on_cpu+0x98/0xc0
[  132.121702] [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR
[  132.121947]  ? __traceiter_workqueue_execute_end+0x40/0x40
[  132.123270]  ? pci_device_shutdown+0x60/0x60
[  132.123880]  pci_device_probe+0x1bc/0x1d0
[  132.124475]  really_probe+0x102/0x450
[  132.125060]  __driver_probe_device+0x100/0x170
[  132.125641]  driver_probe_device+0x1f/0xa0
[  132.126215]  __device_attach_driver+0x6b/0xe0
[  132.126797]  ? driver_allows_async_probing+0x50/0x50
[  132.127383]  ? driver_allows_async_probing+0x50/0x50
[  132.127960]  bus_for_each_drv+0x6a/0xb0
[  132.128528]  __device_attach+0xe2/0x160
[  132.129095]  pci_bus_add_device+0x4a/0x80
[  132.129659]  pci_bus_add_devices+0x2c/0x70
[  132.130213]  pci_bus_add_devices+0x65/0x70
[  132.130753]  pci_bus_add_devices+0x65/0x70
[  132.131283]  pci_bus_add_devices+0x65/0x70
[  132.131780]  pci_bus_add_devices+0x65/0x70
[  132.132270]  pci_bus_add_devices+0x65/0x70
[  132.132757]  pci_rescan_bus+0x23/0x30
[  132.133233]  rescan_store+0x61/0x90
[  132.133701]  kernfs_fop_write_iter+0x132/0x1b0
[  132.134167]  new_sync_write+0x11f/0x1b0
[  132.134627]  vfs_write+0x35b/0x3b0
[  132.135062]  ksys_write+0xa7/0xe0
[  132.135503]  do_syscall_64+0x34/0x80
[  132.135933]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  132.136358] RIP: 0033:0x7f0058a73224
[  132.136775] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
[  132.137663] RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  132.138121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0058a=
73224
[  132.138590] RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 00000000000=
00001
[  132.139064] RBP: 000055d466c24450 R08: 000000000000000a R09: 00000000000=
00001
[  132.139532] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0058d=
4f760
[  132.140003] R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 00007f0058d=
4a760
[  132.140485]  </TASK>
[  132.183669] amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode is=
 not available
[  132.184214] amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode is n=
ot available
[  132.184735] amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[  132.185234] amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[  132.185823] amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable
[  132.186327] amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table revision(for=
mat.content): 4.6
[  132.188783] amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully=
!
[  132.190039] [drm] kiq ring mec 2 pipe 1 q 0
[  132.203608] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[  132.204178] [drm] JPEG decode initialized successfully.
[  132.246079] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  132.327589] memmap_init_zone_device initialised 8388608 pages in 64ms
[  132.328139] amdgpu: HMM registered 32752MB device memory
[  132.328784] amdgpu: Virtual CRAT table created for GPU
[  132.329844] amdgpu: Topology: Add dGPU node [0x738c:0x1002]
[  132.330387] kfd kfd: amdgpu: added device 1002:738c
[  132.330965] amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 16=
, active_cu_number 72
[  132.331725] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 0 on hub 0
[  132.332296] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 1 on hub 0
[  132.332856] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 4 on hub 0
[  132.333414] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 5 on hub 0
[  132.333965] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 6 on hub 0
[  132.334507] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 7 on hub 0
[  132.335057] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 8 on hub 0
[  132.335594] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 9 on hub 0
[  132.336137] amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng =
10 on hub 0
[  132.336679] amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 1
[  132.337234] amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on=
 hub 1
[  132.337790] amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 on=
 hub 1
[  132.338343] amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 on=
 hub 1
[  132.338906] amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 on=
 hub 1
[  132.339448] amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 on=
 hub 2
[  132.339987] amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 on=
 hub 2
[  132.340519] amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 on=
 hub 2
[  132.341041] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
5 on hub 2
[  132.341570] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 6 on hub 2
[  132.342101] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 7 on hub 2
[  132.342630] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv eng =
8 on hub 2
[  132.343152] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv en=
g 9 on hub 2
[  132.343657] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv en=
g 10 on hub 2
[  132.344136] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv eng=
 11 on hub 2
[  132.344610] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv eng=
 12 on hub 2
[  132.378213] amdgpu: Detected AMDGPU 6 Perf Events.
[  132.387349] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 on=
 minor 1
[  132.388530] pcieport 0000:d7:00.0: bridge window [io  0x1000-0x0fff] to =
[bus d8] add_size 1000
[  132.389078] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000=
]
[  132.389600] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 0x=
1000]
[  132.390091] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000=
]
[  132.390568] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 0x=
1000]
[  155.359200] HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 0000=
7ffc9b3bb610 error 4 in libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb0=
00]
[  155.360268] Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 c7 =
fb ff 48 8b 5d f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8 <48=
> 8b 40 68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8

Best regards,
Shuotao

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com<mailto:andrey.grodzovsky=
@amd.com>>
Date: Wednesday, April 6, 2022 at 10:36 PM
To: Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>>, a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.com>>,=
 Lei Qu <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>, Peng Cheng <pe=
ngc@microsoft.com<mailto:pengc@microsoft.com>>, Ran Shu <Ran.Shu@microsoft.=
com<mailto:Ran.Shu@microsoft.com>>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
[You don't often get email from andrey.grodzovsky@amd.com<mailto:andrey.gro=
dzovsky@amd.com>. Learn why this is important at http://aka.ms/LearnAboutSe=
nderIdentification.]<https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&data=3D04%7C01%7=
CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=
=3DLbbAV1OQ4XQeexmn9Hbycdj4sTHqDpKccOJluVwIWpM%3D&reserved=3D0>

Can you attach dmesg for the failure without your patch against
amd-staging-drm-next ?

Also, in general, patches for amdgpu upstream branches should be
submitted to amd-gfx mailing list inline using git-send which makes it
easy to comment and review them inline.

Andrey

On 2022-04-06 10:25, Shuotao Xu wrote:
> Hi Andrey,
>
> We just tried kernel 5.16 based on
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Cshuotaoxu%40micr=
osoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011=
db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=3D0<https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freede=
sktop.org%2Fagd5f%2Flinux.git&data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8=
b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6=
37849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM=
zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3D5%2FFxe0DQhYILPSRl%2FWOzDW=
g2N3jzRXGsUhYHsYuJ0yE%3D&reserved=3D0>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl=
ab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Cshuotaoxu%40mic=
rosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd01=
1db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat=
a=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=3D0<https=
://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freed=
esktop.org%2Fagd5f%2Flinux.git&data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa=
8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3D5%2FFxe0DQhYILPSRl%2FWOzD=
Wg2N3jzRXGsUhYHsYuJ0yE%3D&reserved=3D0>>
> amd-staging-drm-next branch, and found out that hotplug did not work out
> of box for Rocm compute stack.
>
> We did not try the rendering stack since we currently are more focused
> on AI workloads.
>
> We have also created a patch against the amd-staging-drm-next branch to
> enable hotplug for ROCM stack, which were sent in another later email
> with same subject. I am attaching the patch in this email, in case that
> you would want to delete that later email.
>
> Best regards,
>
> Shuotao
>
> *From: *Andrey Grodzovsky <andrey.grodzovsky@amd.com<mailto:andrey.grodzo=
vsky@amd.com>>
> *Date: *Wednesday, April 6, 2022 at 10:13 PM
> *To: *Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>=
>,
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
> *Cc: *Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.co=
m>>, Lei Qu
> <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>, Peng Cheng <pengc@mi=
crosoft.com<mailto:pengc@microsoft.com>>, Ran Shu
> <Ran.Shu@microsoft.com<mailto:Ran.Shu@microsoft.com>>
> *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
>
> [You don't often get email from andrey.grodzovsky@amd.com<mailto:andrey.g=
rodzovsky@amd.com>. Learn why
> this is important at http://aka.ms/LearnAboutSenderIdentification.]<https=
://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.ms%2FLear=
nAboutSenderIdentification.%255d&data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6=
fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%=
7C637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3DLbbAV1OQ4XQeexmn9Hbycdj=
4sTHqDpKccOJluVwIWpM%3D&reserved=3D0>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.m=
s%2FLearnAboutSenderIdentification.%255d&amp;data=3D05%7C01%7Cshuotaoxu%40m=
icrosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd=
011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sd=
ata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi4%3D&amp;reserved=3D0<htt=
ps://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.ms%2FLe=
arnAboutSenderIdentification.%255d&data=3D04%7C01%7CMukul.Joshi%40amd.com%7=
C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C=
0%7C637849457140806742%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3DRLbrnUoTh8SIBZsv9Jiej=
pNMcBzS4BSZ2bswvPNHHd0%3D&reserved=3D0>>
>
> Looks like you are using 5.13 kernel for this work, FYI we added
> hot plug support for the graphic stack in 5.14 kernel (see
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.p=
horonix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unpl=
ug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308d=
a17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8=
xmO2T6jnpipzo%3D&amp;reserved=3D0)<https://nam11.safelinks.protection.outlo=
ok.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%=
26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=3D04%7C01%7CMukul.Joshi%40amd.com%=
7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637849457140806742%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3DMHTv9TxiEISAwOKUfW7s=
hx7NTm82iRg4Tljz%2F6K4cYw%3D&reserved=3D0>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.=
phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unp=
lug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308=
da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN=
8xmO2T6jnpipzo%3D&amp;reserved=3D0<https://nam11.safelinks.protection.outlo=
ok.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%=
26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=3D04%7C01%7CMukul.Joshi%40amd.com%=
7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637849457140806742%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=3DMHTv9TxiEISAwOKUfW7s=
hx7NTm82iRg4Tljz%2F6K4cYw%3D&reserved=3D0>>
>
>
> I am not sure about the code part since it all touches KFD driver (KFD
> team can comment on that) - but I was just wondering if you try 5.14
> kernel would things just work for you out of the box ?
>
> Andrey
>
> On 2022-04-05 22:45, Shuotao Xu wrote:
>> Dear AMD Colleagues,
>>
>> We are from Microsoft Research, and are working on GPU disaggregation
>> technology.
>>
>> We have created a new pull requestAdd PCIe hotplug support for amdgpu by
>> xushuotao * Pull Request #131 * RadeonOpenCompute/ROCK-Kernel-Driver
>> (github.com)
>> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D05=
%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f9=
88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000%7C%7C%7C&amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&a=
mp;reserved=3D0
<https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub=
.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=3D04%7C01%7=
CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637849457140806742%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=
=3DBV2K%2FEsSiowqFwVc1XQ8uAKSI6aQItxdV%2BStAjliGN8%3D&reserved=3D0>> <https=
://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2=
FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D05%7C01%7Cs=
huotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f14=
1af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%=
7C%7C&amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;reserv=
ed=3D0<https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
github.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=3D04%=
7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637849457140806742%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000=
&sdata=3DBV2K%2FEsSiowqFwVc1XQ8uAKSI6aQItxdV%2BStAjliGN8%3D&reserved=3D0>>>=
in
>> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
>>
>> We believe the support of hot-plug of GPU devices can open doors for
>> many advanced applications in data center in the next few years, and we
>> would like to have some reviewers on this PR so we can continue further
>> technical discussions around this feature.
>>
>> Would you please help review this PR?
>>
>> Thank you very much!
>>
>> Best regards,
>>
>> Shuotao Xu
>>
>

--_000_DM5PR12MB178632D54A66F1B7DA7A370FEEE69DM5PR12MB1786namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks Shuotao.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">If the IO link clea=
nup works ok for you, you can use this patch as the base for adding your ch=
anges to add Hot Plug support. You can send a separate patch for that.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Mukul<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> Shuotao Xu &lt;shuotaoxu@microsoft.com&gt=
;
<br>
<b>Sent:</b> Thursday, April 7, 2022 12:28 PM<br>
<b>To:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;; Grodzovsky, Andrey &lt=
;Andrey.Grodzovsky@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Ziyue Yang &lt;Ziyue.Yang@microsoft.com&gt;; Lei Qu &lt;Lei.Qu@m=
icrosoft.com&gt;; Peng Cheng &lt;pengc@microsoft.com&gt;; Ran Shu &lt;Ran.S=
hu@microsoft.com&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[CAUTION: External =
Email] <o:p>
</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks Mukul very m=
uch!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The code looks neat=
, although kfd_locked looks still would cause trouble. I will try it.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Joshi, Mukul &lt;<a=
 href=3D"mailto:Mukul.Joshi@amd.com">Mukul.Joshi@amd.com</a>&gt;<br>
<b>Date: </b>Friday, April 8, 2022 at 12:23 AM<br>
<b>To: </b>Shuotao Xu &lt;<a href=3D"mailto:shuotaoxu@microsoft.com">shuota=
oxu@microsoft.com</a>&gt;, Grodzovsky, Andrey &lt;<a href=3D"mailto:Andrey.=
Grodzovsky@amd.com">Andrey.Grodzovsky@amd.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;, Lei Qu &lt;<a href=3D"mailto:Lei.Qu@microsoft.=
com">Lei.Qu@microsoft.com</a>&gt;, Peng Cheng &lt;<a href=3D"mailto:pengc@m=
icrosoft.com">pengc@microsoft.com</a>&gt;, Ran Shu &lt;<a href=3D"mailto:Ra=
n.Shu@microsoft.com">Ran.Shu@microsoft.com</a>&gt;<br>
<b>Subject: </b>RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport<o:p></o:p></span></p>
</div>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Shuotao,</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Just sent out the p=
atch to cleanup IO links upon KFD device removal to the public mailing list=
.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Please try it, revi=
ew it and let us know how it goes for you.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thank you.</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Mukul</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> Shuotao Xu &lt;<a href=3D"mailto:shuotaox=
u@microsoft.com">shuotaoxu@microsoft.com</a>&gt;
<br>
<b>Sent:</b> Thursday, April 7, 2022 11:09 AM<br>
<b>To:</b> Joshi, Mukul &lt;<a href=3D"mailto:Mukul.Joshi@amd.com">Mukul.Jo=
shi@amd.com</a>&gt;; Grodzovsky, Andrey &lt;<a href=3D"mailto:Andrey.Grodzo=
vsky@amd.com">Andrey.Grodzovsky@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;; Lei Qu &lt;<a href=3D"mailto:Lei.Qu@microsoft.=
com">Lei.Qu@microsoft.com</a>&gt;; Peng Cheng &lt;<a href=3D"mailto:pengc@m=
icrosoft.com">pengc@microsoft.com</a>&gt;; Ran Shu &lt;<a href=3D"mailto:Ra=
n.Shu@microsoft.com">Ran.Shu@microsoft.com</a>&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[CAUTION: External =
Email] </span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Joshi,</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Per your comment, I=
 produced a fix to work with multi-GPU system for hotplug support for our g=
roup&#8217;s internal usage.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have tested on a =
4-node MI100 system, which seems to be working. It is pushed in the github =
PR.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The details are in:=
 <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131%23iss=
uecomment-1091843803&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a7=
017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637849=
457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DyGHto9N07npETzwdiPitfQF4J0N=
ZFuKBdD%2FZQ8NpwJM%3D&amp;reserved=3D0">
https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/pull/131#issuecomme=
nt-1091843803</a></span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I will send the pat=
ch to the mail-list also.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">May I know when you=
r patch is ready for public review?</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">All the best,</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Joshi, Mukul &lt;<a=
 href=3D"mailto:Mukul.Joshi@amd.com">Mukul.Joshi@amd.com</a>&gt;<br>
<b>Date: </b>Thursday, April 7, 2022 at 10:24 AM<br>
<b>To: </b>Shuotao Xu &lt;<a href=3D"mailto:shuotaoxu@microsoft.com">shuota=
oxu@microsoft.com</a>&gt;, Grodzovsky, Andrey &lt;<a href=3D"mailto:Andrey.=
Grodzovsky@amd.com">Andrey.Grodzovsky@amd.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;, Lei Qu &lt;<a href=3D"mailto:Lei.Qu@microsoft.=
com">Lei.Qu@microsoft.com</a>&gt;, Peng Cheng &lt;<a href=3D"mailto:pengc@m=
icrosoft.com">pengc@microsoft.com</a>&gt;, Ran Shu &lt;<a href=3D"mailto:Ra=
n.Shu@microsoft.com">Ran.Shu@microsoft.com</a>&gt;<br>
<b>Subject: </b>RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport</span><o:p></o:p></p>
</div>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%;cellpadding:0;ce=
llspacing:0;display:table;border-collapse:seperate;float:none">
<tbody>
<tr>
<td style=3D"background:#A6A6A6;padding:5.25pt 1.5pt 5.25pt 1.5pt;valign:mi=
ddle"></td>
<td width=3D"100%" style=3D"width:100.0%;background:#EAEAEA;padding:5.25pt =
3.75pt 5.25pt 11.25pt">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<span style=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,sans-serif;=
color:#212121">You don't often get email from
<a href=3D"mailto:mukul.joshi@amd.com">mukul.joshi@amd.com</a>. <a href=3D"=
http://aka.ms/LearnAboutSenderIdentification">
Learn why this is important</a></span><o:p></o:p></p>
</div>
</td>
<td width=3D"75" style=3D"width:56.25pt;background:#EAEAEA;padding:5.25pt 3=
.75pt 5.25pt 3.75pt;align:left">
</td>
</tr>
</tbody>
</table>
<div>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Shuotao,</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks for your pat=
ch.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have been working=
 on something similar as I also found that we don&#8217;t cleanup IO links =
upon device removal.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The IO-links cleanu=
p change in your patch would work only either on a single GPU system or a m=
ulti-GPU system where the last node (in the sysfs topology) is hot-plugged =
out. That&#8217;s because of the way the atomic
 counter, topology_crat_proximity_domain, is used in the code.</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have a patch whic=
h takes care of these issues on a multi-GPU system.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I should be able to=
 send that out for review in sometime.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Mukul</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bou=
nces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Shuotao Xu<br>
<b>Sent:</b> Wednesday, April 6, 2022 11:12 AM<br>
<b>To:</b> Grodzovsky, Andrey &lt;<a href=3D"mailto:Andrey.Grodzovsky@amd.c=
om">Andrey.Grodzovsky@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;; Lei Qu &lt;<a href=3D"mailto:Lei.Qu@microsoft.=
com">Lei.Qu@microsoft.com</a>&gt;; Peng Cheng &lt;<a href=3D"mailto:pengc@m=
icrosoft.com">pengc@microsoft.com</a>&gt;; Ran Shu &lt;<a href=3D"mailto:Ra=
n.Shu@microsoft.com">Ran.Shu@microsoft.com</a>&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[CAUTION: External =
Email] </span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Andrey,</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks for your kin=
d comment on linux patch submission protocol, please let me know if there i=
s anyway to rectify it.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">dmesg is fine excep=
t with some warning during pci rescan after pci removal of an AMD MI100.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The issue is that a=
fter this rocm application will return segfault with the amdgpu driver unle=
ss the entire amdgpu kernel module is unloaded and loaded, which we did not=
 meet our hotplug requirement. The issues
 upon investigation are</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1) kfd_lock is lock=
ed after hotplug, and kfd_open will return fault right away to libhsakmt .
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2) iolink/p2plink h=
as anormalies after hotplug, and libhsakmt will found such anomalies and re=
turn error.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Our patch has been =
tested with a single-instance AMD MI100 GPU and showed it worked.</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I am attaching the =
dmesg after rescan anyway, which will show the warning and the segfault.</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054822]=
 pci 0000:43:00.0: [1002:738c] type 00 class 0x038000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054856]=
 pci 0000:43:00.0: reg 0x10: [mem 0x38b000000000-0x38b7ffffffff 64bit pref]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054877]=
 pci 0000:43:00.0: reg 0x18: [mem 0x38b800000000-0x38b8001fffff 64bit pref]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054890]=
 pci 0000:43:00.0: reg 0x20: [io&nbsp; 0xa000-0xa0ff]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054904]=
 pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054918]=
 pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.055134]=
 pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.055217]=
 pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8.0 GT/=
s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe=
 x16 link)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.056001]=
 pci 0000:43:00.0: Adding to iommu group 73</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057943]=
 pci 0000:43:00.0: BAR 0: assigned [mem 0x38b000000000-0x38b7ffffffff 64bit=
 pref]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057960]=
 pci 0000:43:00.0: BAR 2: assigned [mem 0x38b800000000-0x38b8001fffff 64bit=
 pref]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057974]=
 pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff]</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057981]=
 pci 0000:43:00.0: BAR 6: assigned [mem 0xb8480000-0xb849ffff pref]</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057984]=
 pci 0000:43:00.0: BAR 4: assigned [io&nbsp; 0xa000-0xa0ff]</span><o:p></o:=
p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058429]=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058453]=
 WARNING: possible circular locking dependency detected</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058477]=
 5.16.0-kfd+ #1 Not tainted</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058492]=
 ------------------------------------------------------</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058515]=
 bash/3632 is trying to acquire lock:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058534]=
 ffffadee20adfb50 ((work_completion)(&amp;wfc.work)){+.+.}-{0:0}, at: __flu=
sh_work+0x2f5/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058554]=
 [drm] initializing kernel modesetting (ARCTURUS 0x1002:0x738C 0x1002:0x0C3=
4 0x01).</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058577]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but task =
is already holding lock:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058580]=
 ffffffffa3c62308</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058630]=
 amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not support=
ed</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058638]=
&nbsp; (</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058678]=
 [drm] register mmio base: 0xB8400000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058683]=
 pci_rescan_remove_lock</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058694]=
 [drm] register mmio size: 524288</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058713]=
 ){+.+.}-{3:3}, at: rescan_store+0x55/0x90</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058773]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which loc=
k already depends on the new lock.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058804]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the exist=
ing dependency chain (in reverse order) is:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058819]=
 [drm] add ip block number 0 &lt;soc15_common&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058831]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; #1 =
(</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058854]=
 [drm] add ip block number 1 &lt;gmc_v9_0&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058858]=
 [drm] add ip block number 2 &lt;vega20_ih&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058874]=
 pci_rescan_remove_lock</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058894]=
 [drm] add ip block number 3 &lt;psp&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058915]=
 ){+.+.}-{3:3}</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058931]=
 [drm] add ip block number 4 &lt;smu&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058951]=
 :</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058965]=
 [drm] add ip block number 5 &lt;gfx_v9_0&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058986]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __mutex_lock+0xa4/0x990</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058996]=
 [drm] add ip block number 6 &lt;sdma_v4_0&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059016]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_add_tco_spt.isra.20+0x2a/0x=
1a0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059033]=
 [drm] add ip block number 7 &lt;vcn_v2_5&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059054]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_add_tco+0xf6/0x110</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059075]=
 [drm] add ip block number 8 &lt;jpeg_v2_5&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059096]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_probe+0x402/0x860</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059151]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local_pci_probe+0x40/0x90</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059170]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_for_cpu_fn+0x10/0x20</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059189]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_one_work+0x2a4/0x640</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059208]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; worker_thread+0x228/0x3f0</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059227]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kthread+0x16d/0x1a0</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059795]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_from_fork+0x1f/0x30</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.060337]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; #0 =
((work_completion)(&amp;wfc.work)){+.+.}-{0:0}:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.061405]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __lock_acquire+0x1552/0x1ac0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.061950]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_acquire+0x26c/0x300</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.062484]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __flush_work+0x315/0x470</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.063009]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_on_cpu+0x98/0xc0</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.063526]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_device_probe+0x1bc/0x1d0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.064036]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; really_probe+0x102/0x450</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.064532]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __driver_probe_device+0x100/0x17=
0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065020]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver_probe_device+0x1f/0xa0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065497]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __device_attach_driver+0x6b/0xe0=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065975]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus_for_each_drv+0x6a/0xb0</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.066449]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __device_attach+0xe2/0x160</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.066912]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_device+0x4a/0x80</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.067365]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x2c/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.067812]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068253]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068688]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068936]=
 amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.069109]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.069602]=
 amdgpu: ATOM BIOS: 113-D3431401-X00</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070058]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070572]=
 [drm] VCN(0) decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070997]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_rescan_bus+0x23/0x30</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071000]=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rescan_store+0x61/0x90</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071003]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernfs_fop_write_iter+0x132/0x1b=
0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071501]=
 [drm] VCN(1) decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071964]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_sync_write+0x11f/0x1b0</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.072432]=
 [drm] VCN(0) encode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.072900]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfs_write+0x35b/0x3b0</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.073376]=
 [drm] VCN(1) encode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.073847]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ksys_write+0xa7/0xe0</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074335]=
 [drm] JPEG(0) JPEG decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074803]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_syscall_64+0x34/0x80</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074808]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_SYSCALL_64_after_hwframe+0=
x44/0xae</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074811]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other inf=
o that might help us debug this:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074813]=
&nbsp; Possible unsafe locking scenario:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.075302]=
 [drm] JPEG(1) JPEG decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.075779]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; CPU1</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.076361]=
 amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.076765]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ----</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.077265]=
 amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078649]=
&nbsp;&nbsp; lock(pci_rescan_remove_lock);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078652]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock((work_completion)(&amp;wfc.work))=
;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078653]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock(pci_rescan_remove_lock);</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078655]=
&nbsp;&nbsp; lock((work_completion)(&amp;wfc.work));</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078656]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ***=
 DEADLOCK ***</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078656]=
 5 locks held by bash/3632:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078658]=
&nbsp; #0: ffff9c39c7b89438</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.079612]=
 amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized successfully, hardw=
are ability[7fff] ras_mask[7fff]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.080089]=
&nbsp; (</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.080602]=
 [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size i=
s 9-bit</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.081082]=
 sb_writers</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.081601]=
 amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 0x0000008000000000 - 0x00000087F=
EFFFFFF (32752M used)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.082102]=
 #6</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.082630]=
 amdgpu 0000:43:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FF=
FFFFF</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.083152]=
 ){.+.+}-{0:0}</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.083687]=
 amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 0x0000008800000000 - 0x0000FF=
FFFFFFFFFF</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.084210]=
 , at: ksys_write+0xa7/0xe0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.085708]=
 [drm] Detected VRAM RAM=3D32752M, BAR=3D32768M</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.086205]=
&nbsp; #1:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.086733]=
 [drm] RAM width 4096bits HBM</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.087269]=
 ffff9c5959011088</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.087890]=
 [drm] amdgpu: 32752M of VRAM memory ready</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.088389]=
&nbsp; (</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.088972]=
 [drm] amdgpu: 32752M of GTT memory ready.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.089572]=
 &amp;of-&gt;mutex</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090206]=
 [drm] GART: num cpu pages 131072, num gpu pages 131072</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090804]=
 ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090808]=
&nbsp; #2: ffff9c39c882a9e0 (kn-&gt;active#423){.+.+}-{0:0}, at: kernfs_fop=
_write_iter+0x10c/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.091639]=
 [drm] PCIE GART of 512M enabled.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.092117]=
&nbsp; #3:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.092801]=
 [drm] PTB located at 0x0000008000000000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.093480]=
 ffffffffa3c62308</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094566]=
 amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't exist</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094822]=
&nbsp; (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x55/0x90</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094827]=
 &nbsp;#4: ffff9c597392b248 (&amp;dev-&gt;mutex){....}-{3:3}, at: __device_=
attach+0x39/0x160</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094835]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stack bac=
ktrace:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.097098]=
 [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 21</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.097467]=
 CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098169]=
 amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN firmware</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098839]=
 Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/20=
18</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098841]=
 Call Trace:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098842]=
&nbsp; &lt;TASK&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098843]=
&nbsp; dump_stack_lvl+0x44/0x57</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098848]=
&nbsp; check_noncircular+0x105/0x120</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098853]=
&nbsp; ? unwind_get_return_address+0x1b/0x30</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.112924]=
&nbsp; ? register_lock_class+0x46/0x780</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.113630]=
&nbsp; ? __lock_acquire+0x1552/0x1ac0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.114342]=
&nbsp; __lock_acquire+0x1552/0x1ac0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.115050]=
&nbsp; lock_acquire+0x26c/0x300</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.115755]=
&nbsp; ? __flush_work+0x2f5/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.116460]=
&nbsp; ? lock_is_held_type+0xdf/0x130</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.117177]=
&nbsp; __flush_work+0x315/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.117890]=
&nbsp; ? __flush_work+0x2f5/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.118604]=
&nbsp; ? lock_is_held_type+0xdf/0x130</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.119305]=
&nbsp; ? mark_held_locks+0x49/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.119981]=
&nbsp; ? queue_work_on+0x2f/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.120645]=
&nbsp; ? lockdep_hardirqs_on+0x79/0x100</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121300]=
&nbsp; work_on_cpu+0x98/0xc0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121702]=
 [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121947]=
&nbsp; ? __traceiter_workqueue_execute_end+0x40/0x40</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.123270]=
&nbsp; ? pci_device_shutdown+0x60/0x60</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.123880]=
&nbsp; pci_device_probe+0x1bc/0x1d0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.124475]=
&nbsp; really_probe+0x102/0x450</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.125060]=
&nbsp; __driver_probe_device+0x100/0x170</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.125641]=
&nbsp; driver_probe_device+0x1f/0xa0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.126215]=
&nbsp; __device_attach_driver+0x6b/0xe0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.126797]=
&nbsp; ? driver_allows_async_probing+0x50/0x50</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.127383]=
&nbsp; ? driver_allows_async_probing+0x50/0x50</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.127960]=
&nbsp; bus_for_each_drv+0x6a/0xb0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.128528]=
&nbsp; __device_attach+0xe2/0x160</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.129095]=
&nbsp; pci_bus_add_device+0x4a/0x80</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.129659]=
&nbsp; pci_bus_add_devices+0x2c/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.130213]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.130753]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.131283]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.131780]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.132270]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.132757]=
&nbsp; pci_rescan_bus+0x23/0x30</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.133233]=
&nbsp; rescan_store+0x61/0x90</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.133701]=
&nbsp; kernfs_fop_write_iter+0x132/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.134167]=
&nbsp; new_sync_write+0x11f/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.134627]=
&nbsp; vfs_write+0x35b/0x3b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135062]=
&nbsp; ksys_write+0xa7/0xe0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135503]=
&nbsp; do_syscall_64+0x34/0x80</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135933]=
&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xae</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.136358]=
 RIP: 0033:0x7f0058a73224</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.136775]=
 Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48=
 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 &lt;48&gt; 3d 00 =
f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53
 48 89 f5</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.137663]=
 RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.138121]=
 RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0058a73224</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.138590]=
 RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 0000000000000001</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.139064]=
 RBP: 000055d466c24450 R08: 000000000000000a R09: 0000000000000001</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.139532]=
 R10: 000000000000000a R11: 0000000000000246 R12: 00007f0058d4f760</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.140003]=
 R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 00007f0058d4a760</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.140485]=
&nbsp; &lt;/TASK&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.183669]=
 amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode is not available=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.184214]=
 amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode is not available</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.184735]=
 amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode is not available</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.185234]=
 amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not =
available</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.185823]=
 amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.186327]=
 amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table revision(format.content): =
4.6</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.188783]=
 amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully!</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.190039]=
 [drm] kiq ring mec 2 pipe 1 q 0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.203608]=
 [drm] VCN decode and encode initialized successfully(under DPG Mode).</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.204178]=
 [drm] JPEG decode initialized successfully.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.246079]=
 kfd kfd: amdgpu: Allocated 3969056 bytes on gart</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.327589]=
 memmap_init_zone_device initialised 8388608 pages in 64ms</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.328139]=
 amdgpu: HMM registered 32752MB device memory</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.328784]=
 amdgpu: Virtual CRAT table created for GPU</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.329844]=
 amdgpu: Topology: Add dGPU node [0x738c:0x1002]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.330387]=
 kfd kfd: amdgpu: added device 1002:738c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.330965]=
 amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 16, active_cu_nu=
mber 72</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.331725]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 0 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.332296]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 1 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.332856]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 4 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.333414]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 5 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.333965]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 6 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.334507]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 7 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.335057]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 8 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.335594]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 9 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.336137]=
 amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 10 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.336679]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.337234]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.337790]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.338343]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.338906]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.339448]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 on hub 2</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.339987]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 on hub 2</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.340519]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 on hub 2</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.341041]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 5 on hub 2</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.341570]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 6 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.342101]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 7 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.342630]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv eng 8 on hub 2</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.343152]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 9 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.343657]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv eng 10 on hub 2<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.344136]=
 amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv eng 11 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.344610]=
 amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv eng 12 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.378213]=
 amdgpu: Detected AMDGPU 6 Perf Events.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.387349]=
 [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 on minor 1</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.388530]=
 pcieport 0000:d7:00.0: bridge window [io&nbsp; 0x1000-0x0fff] to [bus d8] =
add_size 1000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.389078]=
 pcieport 0000:d7:00.0: BAR 13: no space for [io&nbsp; size 0x1000]</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.389600]=
 pcieport 0000:d7:00.0: BAR 13: failed to assign [io&nbsp; size 0x1000]</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.390091]=
 pcieport 0000:d7:00.0: BAR 13: no space for [io&nbsp; size 0x1000]</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.390568]=
 pcieport 0000:d7:00.0: BAR 13: failed to assign [io&nbsp; size 0x1000]</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 155.359200]=
 HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 00007ffc9b3bb610 e=
rror 4 in libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb000]</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 155.360268]=
 Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 c7 fb ff 48 8b 5d=
 f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8 &lt;48&gt; 8b 40 =
68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48
 8b 45 f8</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Andrey Grodzovsky &=
lt;<a href=3D"mailto:andrey.grodzovsky@amd.com">andrey.grodzovsky@amd.com</=
a>&gt;<br>
<b>Date: </b>Wednesday, April 6, 2022 at 10:36 PM<br>
<b>To: </b>Shuotao Xu &lt;<a href=3D"mailto:shuotaoxu@microsoft.com">shuota=
oxu@microsoft.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;, Lei Qu &lt;<a href=3D"mailto:Lei.Qu@microsoft.=
com">Lei.Qu@microsoft.com</a>&gt;, Peng Cheng &lt;<a href=3D"mailto:pengc@m=
icrosoft.com">pengc@microsoft.com</a>&gt;, Ran Shu &lt;<a href=3D"mailto:Ra=
n.Shu@microsoft.com">Ran.Shu@microsoft.com</a>&gt;<br>
<b>Subject: </b>Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[You don't often ge=
t email from
<a href=3D"mailto:andrey.grodzovsky@amd.com">andrey.grodzovsky@amd.com</a>.=
 Learn why this is important at
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F=
%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;data=3D04%7C01%7CMukul=
.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=
=3DLbbAV1OQ4XQeexmn9Hbycdj4sTHqDpKccOJluVwIWpM%3D&amp;reserved=3D0">
http://aka.ms/LearnAboutSenderIdentification.]</a><br>
<br>
Can you attach dmesg for the failure without your patch against<br>
amd-staging-drm-next ?<br>
<br>
Also, in general, patches for amdgpu upstream branches should be<br>
submitted to amd-gfx mailing list inline using git-send which makes it<br>
easy to comment and review them inline.<br>
<br>
Andrey<br>
<br>
On 2022-04-06 10:25, Shuotao Xu wrote:<br>
&gt; Hi Andrey,<br>
&gt;<br>
&gt; We just tried kernel 5.16 based on<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D04%7C01%7CMu=
kul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdat=
a=3D5%2FFxe0DQhYILPSRl%2FWOzDWg2N3jzRXGsUhYHsYuJ0yE%3D&amp;reserved=3D0">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7C01%7Cshuotaoxu%40mi=
crosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd0=
11db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp=
;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;amp;reserved=
=3D0</a><br>
&gt; &lt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D04%7C01%=
7CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637849457140650516%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;=
sdata=3D5%2FFxe0DQhYILPSRl%2FWOzDWg2N3jzRXGsUhYHsYuJ0yE%3D&amp;reserved=3D0=
">https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7C01%7Cshuotaoxu%40=
microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7c=
d011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;a=
mp;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;amp;reserve=
d=3D0</a>&gt;<br>
&gt; amd-staging-drm-next branch, and found out that hotplug did not work o=
ut<br>
&gt; of box for Rocm compute stack.<br>
&gt;<br>
&gt; We did not try the rendering stack since we currently are more focused=
<br>
&gt; on AI workloads.<br>
&gt;<br>
&gt; We have also created a patch against the amd-staging-drm-next branch t=
o<br>
&gt; enable hotplug for ROCM stack, which were sent in another later email<=
br>
&gt; with same subject. I am attaching the patch in this email, in case tha=
t<br>
&gt; you would want to delete that later email.<br>
&gt;<br>
&gt; Best regards,<br>
&gt;<br>
&gt; Shuotao<br>
&gt;<br>
&gt; *From: *Andrey Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky@amd.=
com">andrey.grodzovsky@amd.com</a>&gt;<br>
&gt; *Date: *Wednesday, April 6, 2022 at 10:13 PM<br>
&gt; *To: *Shuotao Xu &lt;<a href=3D"mailto:shuotaoxu@microsoft.com">shuota=
oxu@microsoft.com</a>&gt;,<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@l=
ists.freedesktop.org</a>&gt;<br>
&gt; *Cc: *Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;, Lei Qu<br>
&gt; &lt;<a href=3D"mailto:Lei.Qu@microsoft.com">Lei.Qu@microsoft.com</a>&g=
t;, Peng Cheng &lt;<a href=3D"mailto:pengc@microsoft.com">pengc@microsoft.c=
om</a>&gt;, Ran Shu<br>
&gt; &lt;<a href=3D"mailto:Ran.Shu@microsoft.com">Ran.Shu@microsoft.com</a>=
&gt;<br>
&gt; *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Suppo=
rt<br>
&gt;<br>
&gt; [You don't often get email from <a href=3D"mailto:andrey.grodzovsky@am=
d.com">andrey.grodzovsky@amd.com</a>. Learn why<br>
&gt; this is important at <a href=3D"https://nam11.safelinks.protection.out=
look.com/?url=3Dhttp%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&=
amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a6=
49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637849457140650516%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C2000&amp;sdata=3DLbbAV1OQ4XQeexmn9Hbycdj4sTHqDpKccOJluVwIWpM%3D&a=
mp;reserved=3D0">
http://aka.ms/LearnAboutSenderIdentification.]</a><br>
&gt; &lt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttp%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;data=3D04%7C0=
1%7CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608da18b3a649%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637849457140806742%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&am=
p;sdata=3DRLbrnUoTh8SIBZsv9JiejpNMcBzS4BSZ2bswvPNHHd0%3D&amp;reserved=3D0">=
https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.ms%2=
FLearnAboutSenderIdentification.%255d&amp;amp;data=3D05%7C01%7Cshuotaoxu%40=
microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7c=
d011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;a=
mp;sdata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi4%3D&amp;amp;reserve=
d=3D0</a>&gt;<br>
&gt;<br>
&gt; Looks like you are using 5.13 kernel for this work, FYI we added<br>
&gt; hot plug support for the graphic stack in 5.14 kernel (see<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-A=
MDGPU-Hot-Unplug&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a70174=
68299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378494571=
40806742%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DMHTv9TxiEISAwOKUfW7shx7NTm82iRg=
4Tljz%2F6K4cYw%3D&amp;reserved=3D0">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.pho=
ronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug=
&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b8730=
8da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf=
16IGN8xmO2T6jnpipzo%3D&amp;amp;reserved=3D0)</a><br>
&gt; &lt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.=
14-AMDGPU-Hot-Unplug&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a7=
017468299e608da18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637849=
457140806742%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DMHTv9TxiEISAwOKUfW7shx7NTm8=
2iRg4Tljz%2F6K4cYw%3D&amp;reserved=3D0">https://nam06.safelinks.protection.=
outlook.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_=
item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;amp;data=3D05%7C01%7Cshuotaoxu=
%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2=
d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am=
p;amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8xmO2T6jnpipzo%3D&amp;amp;rese=
rved=3D0</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; I am not sure about the code part since it all touches KFD driver (KFD=
<br>
&gt; team can comment on that) - but I was just wondering if you try 5.14<b=
r>
&gt; kernel would things just work for you out of the box ?<br>
&gt;<br>
&gt; Andrey<br>
&gt;<br>
&gt; On 2022-04-05 22:45, Shuotao Xu wrote:<br>
&gt;&gt; Dear AMD Colleagues,<br>
&gt;&gt;<br>
&gt;&gt; We are from Microsoft Research, and are working on GPU disaggregat=
ion<br>
&gt;&gt; technology.<br>
&gt;&gt;<br>
&gt;&gt; We have created a new pull requestAdd PCIe hotplug support for amd=
gpu by<br>
&gt;&gt; xushuotao &middot; Pull Request #131 &middot; RadeonOpenCompute/RO=
CK-Kernel-Driver<br>
&gt;&gt; (github.com)<br>
&gt;&gt; &lt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull=
%2F131&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608d=
a18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637849457140806742%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C2000&amp;sdata=3DBV2K%2FEsSiowqFwVc1XQ8uAKSI6aQItxdV%2BStA=
jliGN8%3D&amp;reserved=3D0">https://nam06.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2F=
pull%2F131&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60=
541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63784852=
6184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DqEeZR6R95jrjAalt=
d1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;amp;reserved=3D0<br>
</a>&gt; &lt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull=
%2F131&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C6fa8b71a7017468299e608d=
a18b3a649%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637849457140806742%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C2000&amp;sdata=3DBV2K%2FEsSiowqFwVc1XQ8uAKSI6aQItxdV%2BStA=
jliGN8%3D&amp;reserved=3D0">https://nam06.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2F=
pull%2F131&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60=
541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63784852=
6184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DqEeZR6R95jrjAalt=
d1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;amp;reserved=3D0</a>&gt;&gt;in<br>
&gt;&gt; ROCK-Kernel-Driver, which will enable PCIe hot-plug support for am=
dgpu.<br>
&gt;&gt;<br>
&gt;&gt; We believe the support of hot-plug of GPU devices can open doors f=
or<br>
&gt;&gt; many advanced applications in data center in the next few years, a=
nd we<br>
&gt;&gt; would like to have some reviewers on this PR so we can continue fu=
rther<br>
&gt;&gt; technical discussions around this feature.<br>
&gt;&gt;<br>
&gt;&gt; Would you please help review this PR?<br>
&gt;&gt;<br>
&gt;&gt; Thank you very much!<br>
&gt;&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt;<br>
&gt;&gt; Shuotao Xu<br>
&gt;&gt;<br>
&gt;</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB178632D54A66F1B7DA7A370FEEE69DM5PR12MB1786namp_--
