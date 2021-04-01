Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB82C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2E061006
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E061006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B006EC63;
	Thu,  1 Apr 2021 06:03:32 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853DB6EC63
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 06:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyETYThEQNyobfr2g2tB+NBpBrimagLstiNMKJzc58QZjNjPldqX7LoegInuFSuKdt/YPRwIY1nhkFEZOAwh4F/5ukYI8jQD4q/Wd1UQjlz2+BwRzo29lhYLX9Rt92Lq8dBhABWuVim7WSTtr7OUSdAI1rNXcftumbfCHQXh0CW5kigRHRGEdKh1GuGFBvlQvIEOlrQTnXHGymW5q/iy7MpqeedUql1foEc+2gKvmqWZ/l2Kqwv28mUhMMmXVnKrfd8lLy20+xLSO7VPJRHKB4wMbeY0JGlh8HcoYjeYpDHiWxmfD556Def0US6BGQ7AgeM7QsxI2BqteeVcUczsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZbsWkiRe7PUamdjRbqhQJLuOUgXAe0iS63XDl6PdAo=;
 b=Zdo+H4d3JgrZPFNTMMXj0Y14/uoz0SLefnVTaZqbsy07UH6ec5KfYZSfwp2zVy9D9EcKye9lTcfviq8PpLReqFEhQq08TcwJokjoQzWD1M9NWHdMqky6NV7Jp5x276CIPD2pFqBSpQQDw1yzkL6035IxG9JcJCSSBx0Tn4PwXrPsi9n3zUERyDgQ1iAMEkwigyqKAJBqriK+CnQRstt6tJRenRMKpFJpf7JkBeHHquDhpTTFwKb+GUdCTmIgASbfFTir6aPOCcR5itG6jY+B6vKRXVt0fSFL0M3dre8j+jfvn09azAkuNIXgHjY8M24y4oWmkMfe4P1qSlpQEsyclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZbsWkiRe7PUamdjRbqhQJLuOUgXAe0iS63XDl6PdAo=;
 b=L4hXIIYA5jj0oerm/jArSfGMHXWLahctZjayPW8LaiUbSr81CrSmiSd+gHQs+DWAYf4Ul8svkJeDkGjxRkRUJM5QYpTEk4xS3ozTFOW3K4rBm38DbZuvcN6z6Ydill9aF6MQmpuCy7pqRn0GUBnE5VTeEexYZDlgwKS0itKMNgA=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 06:03:30 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 06:03:30 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram
 for navi12 sriov
Thread-Topic: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram
 for navi12 sriov
Thread-Index: AQHXJR8IXBSHD58UNUm3b3+j87tUmaqdzn2AgAFgsuA=
Date: Thu, 1 Apr 2021 06:03:29 +0000
Message-ID: <BY5PR12MB41158CAF03F86837B011F5648F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-4-Emily.Deng@amd.com>
 <BY5PR12MB4115AD67320252B43CA577CC8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115AD67320252B43CA577CC8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0d50e74-3927-47a3-ba8f-9a33cf3fed04;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:00:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 636dd449-21d3-4055-ae06-08d8f4d3dfb8
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB400197311E2AE7543544E1168F7B9@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjhBNy7X05gaS1+Ue4hQLaXuUbe7gXg+doGk8aHhq16M5KrTVWdxEhB1tYgSrbZEuqZetaZ8o9q4ICeOwYep2ByMUMGeic2fcQpHjNx27z9DiKamQkTKgd6oirSJVVBRBLeVJwLM3IXFTbcu6ctKzl2inYg7aWBhh1r4VuvT1ua8u8i6PsM9sx8L3/5C0uYdIN/ur2Vzw3SbHX+SBvkLU4Z4g4T9FpBthWqCYzY5U0TpJ04ZiVpes/TBMuNtxfXDUpjHe16H1Lv2YgpQpHlq3b/JVcOYU/vy17txU4NL2ei1PX5YSGjr9wOjBzWLPqZmdokqYzsywZ0zqUqPFx/oScvdibKM+yF/UPVJxbLZAj2ZIF/udc165xqn+oZg2sIRbfgMo57Aad9TMqrwpnXmong3vr2fsxqM9Krc+1nOt98PxFS8XkYtUv80SMVG6eFFzJYH5/Un2nrQ+L+kq6qYeaF1brkn1tJZTpwnrB14y1Xkyk/3YaLaor/EJiK7yzMtgoxtRW0hrMTGREC0RLMU8/1F/+j04AwoAhZAZslEDVVia+g4pi6VXmI9PmFc/4ypDqvITA5X9abpkSNRr2KEMAEVdYTB0oNm6HseoHMgRkZa9/DHzYhRl/S53t3iKBTzEPef38ofWLmZ1GlSIcw3L92qVknsE86wGBgtAvsYq3M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(52536014)(71200400001)(6862004)(186003)(33656002)(64756008)(66476007)(26005)(66556008)(316002)(478600001)(66446008)(4326008)(76116006)(6636002)(5660300002)(66946007)(9686003)(6506007)(8936002)(55016002)(86362001)(83380400001)(7696005)(8676002)(38100700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MhnV/hgX6LXE7ePx3vU16ugGPFbCgdGjXe1+Rh9IlqsVpACpnEXp6T7D3y2y?=
 =?us-ascii?Q?GSjthI0hJuDaDteTZz1uE3qZ72iejVFC1S9yzPajazwToVejPigiTpd9XFgk?=
 =?us-ascii?Q?j5rSexBoy0DvuHeJH3WvRI4rpOWqzx/szxKtWcl1eX6Y3s+Ny1Syd3uWE+p9?=
 =?us-ascii?Q?TiZtvxRHBnkAUp0MrzJdCscJ4zxA7T3NkyN3z+niyI+RWPgI9dngpvQ0PcGa?=
 =?us-ascii?Q?n8XCSHO/hkCJTOZJTXjMdU+vIOmcmVGcdSkJWPh5W2fsdE6GJukiPoPKcCq8?=
 =?us-ascii?Q?qNO+e3+qSBrc6pcFbetgEaT7WBmXUgekUWwfwY/inQZ2DJK1Cg6oeUF5eKdX?=
 =?us-ascii?Q?xo+bzKZwmvmD7SniLKJivwPzQBVyNTx4JbBIxs+dp8AYQj0BHMDa2OPvs5b0?=
 =?us-ascii?Q?R5wZR6SUb/Gc/S27/fWYZ59f6nVd+lwOMl/EAMy9JNUisYEKXbrL5NFUXEoh?=
 =?us-ascii?Q?H/8DfuMmCxeDmgvzvDIgsp9++pvhvkarfJfHapkBdCDMmUr9Cgn9M/2LOz2U?=
 =?us-ascii?Q?Lln7I5FI5jHu/8NL/RURcc4O+CXGRKkMWjFtFTZyvIdf0TBIMP7iATT1lhz7?=
 =?us-ascii?Q?Nxnzw0KL7k/FMbpJ4IBxlF1TSBbayX4ZHvI9x1iMyepjAbzs2qjm7Ox5PIle?=
 =?us-ascii?Q?1UbfixK+HaISVll9RuZ6iklrUxCsKYT1DQwGHaNR0WHd97B5OcYQC9lDQ15P?=
 =?us-ascii?Q?gIPj5lL1198hcJ5fzF20/d2sQ6RE3WgQF3CZ5QeML5aKgPymg6ysMyttLaqA?=
 =?us-ascii?Q?70cYITWnbRom8Ty5VDwIscMQ17U9QUXRWz1hyeNjwBuU1VTY/YbiiC/ZluR/?=
 =?us-ascii?Q?CPNwQFRdSStUjl/bVPJLImoUF96afm9P7c14jAZEsmtQjFmIAJcfg8Dlp15R?=
 =?us-ascii?Q?iA6wBUwlQhAwzMJSYIXykoneCQNTOxVAUmH6ocPszS2+WPoaPe+lMAkCGTkF?=
 =?us-ascii?Q?sNKHbeqQQEZzopCcl7c1zEj1Nd6oPAmRjUlAMHzkGwo2BJ0m0nPFb2xyO8tR?=
 =?us-ascii?Q?PRG9Fc8fTWpW+UwRNFCECBvjTpLAZtltkB1cxeH7wO5D5gd+eLpGzmSOaDip?=
 =?us-ascii?Q?vMHVBnY+WJvBpFDyoKrDWBabl0EbvmeeIsaNY/nl4ejPTzpxYfJmUIEB6VpE?=
 =?us-ascii?Q?QD0oPlAvCws+mzbOVdYr+YpVxms7aexL09xJ6BQ8LlCS3P0zsaSlggsj3N/0?=
 =?us-ascii?Q?h4tdxCxc4KPx9MVO4DVt/eD3VKgsjzj4gLY1pY2Xg+NAN5CR4Of9926s0JEA?=
 =?us-ascii?Q?+SwU0lHpjdjKRkeuVRmp+yZQ04+3M5hgCoHNf8bUOX4nzQlWsr0cD0Oush5e?=
 =?us-ascii?Q?Z14xmpDMciiiTzRB/NXl7rWx?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636dd449-21d3-4055-ae06-08d8f4d3dfb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:03:30.0120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exiejIChiTh72+Ce7ae8r1DMYMG5YGlAfcMuCBWi2ElweBJvnlCTXp62/GFkYHa3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
     Could you help to review this patch?

Best wishes
Emily Deng

>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, March 31, 2021 5:01 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from
>vram for navi12 sriov
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping .....
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, March 30, 2021 12:42 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram
>>for
>>navi12 sriov
>>
>>To fix the board disappear issue.
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>b/drivers/gpu/drm/amd/amdgpu/nv.c index 46d4bbabce75..48dc171bc759
>>100644
>>--- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>@@ -693,6 +693,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>> adev->nbio.funcs = &nbio_v2_3_funcs;
>> adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
>> }
>>+
>>+if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_NAVI12)
>>+amdgpu_discovery = 0;
>>+
>> adev->hdp.funcs = &hdp_v5_0_funcs;
>>
>> if (adev->asic_type >= CHIP_SIENNA_CICHLID)
>>--
>>2.25.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
