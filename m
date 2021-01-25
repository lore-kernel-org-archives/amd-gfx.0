Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 08:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF93E22C9C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 08:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF93E22C9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5437689F61;
	Mon, 25 Jan 2021 08:16:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0690389CC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 08:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdgsC1nMRuoE/aEGrOXKcderzbmCrkGQS4Vnd2L3TQGRGeDrApW26e9ieaMzXUiUYMmYtr59hrbZIgRltAsnypWWbdBB+WV9gg3IuQVYqeSDWqIpHDPjuZDFjLfdoYhuvMWuN/ItnruGxLJp3W2Ld4J63q9UnXZxepywCJmngs4dtj81PLGu1moa3fcOJLFfbr5OjlpVHxRxxa3w0+QlmxSVBvb3IJaAAJoMbeQ1iwoGnrxCP3U2GZ6GLeX9GsQOYKyHc+j5yBsLKzOOaX0DCd1vrx/QhmVs3O0fyNYVAXrrnbAXt8PdUWUZL6Zj4RovwdzezU0WLwMQeOlaoh17tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UHVY1/sZywh85Yrjp4VmGhIJwJc/rWgqiKqi3iijgQ=;
 b=WKEUu+3ftW2+nieGdOezkLibXEwBT4dVeOKhtrOaBRy0IHpOQXdeXu8eOrMx8IlUFe1mNOocms4tu44iouLtjSU8ZHjL/Weh7sH9t/lAFvjytpp0aP9ZmViY/23Z4i8ox6dLJ3lEYdG0pFZnPZrqkSe4Q2SfJI98KFYzBUXEMHJMt3iOXt/HvTh5FrZK+0wvWn12T47JLl6+JtQbDVeeJee5IKeCZA6TSmlLx+D091I2z4OqmYsXdnja8xPcmeM3QUfmuTJs3n4GgvXflIG4KnLlUCasKqf56dq8svClseSc7RXnDAMsr6BJvK8sotiDsoYkyWh2zVhk3b4wtr3/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UHVY1/sZywh85Yrjp4VmGhIJwJc/rWgqiKqi3iijgQ=;
 b=f/EwK+Fv/lBGyNYvImG4pe+Z0kqjDIKWbMuDlXYP68o4sFCrRy+o+H75dGr1wIw0ZaF5H5fssWI3kP95deXd7TcZKPFL2GMhgl/aWg8aem8eOTADUKwNH8eRxojc7LK0ip8MN/j3QR0AaCgaTyzKIBEKCvflGArRsl53xr6rg/Y=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 08:16:28 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::44aa:dfd4:9:1590]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::44aa:dfd4:9:1590%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 08:16:28 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: add error handling to
 amdgpu_virt_read_pf2vf_data
Thread-Topic: [PATCH] drm/amd/amdgpu: add error handling to
 amdgpu_virt_read_pf2vf_data
Thread-Index: AQHW7kJ0Ne5PHvuq10qsWLFev8QVIqoxah+AgAaeDlA=
Date: Mon, 25 Jan 2021 08:16:28 +0000
Message-ID: <DM5PR12MB170803B760404274A6B331AB84BD9@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210119090642.3311634-1-Jingwen.Chen2@amd.com>
 <MWHPR12MB1359E8FE1E6334C9B0F5A497B7A19@MWHPR12MB1359.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB1359E8FE1E6334C9B0F5A497B7A19@MWHPR12MB1359.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2021-01-25T08:16:26Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=14be5a6d-e73b-4a79-9061-0000c71ba901;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2ab198d-92d8-49db-e9b4-08d8c10983c8
x-ms-traffictypediagnostic: DM6PR12MB3771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3771A68016D715BC6B552C1F84BD9@DM6PR12MB3771.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wfaWLmq/B88C5+wOneC1taBIDfqkB3khEC03Q9/B8yAl1gDiZBu2MDgd7Em2JbDIiApKTgllGi+eTg1DWd3Gzw6ELfvT8qnG3S2dH+LUe1MRqo+jMCO0jHatuHo8C82Vs5qF1eFx89pTjVA4xN7CFNXKDyUukujCuer3mbrIcAKuI2C9YosCrN+9ZPdKV1NETeL5pYOT/hyWHzUiwVI4AzuhzaIf8sXzouk8mqUFY217iPHFDS7xpeSLry8iBVAviYmYOVDCV+msCO2sRdV/lrYKW0dIr3vbt1eq3e/uOFnT5DDLGQImaPTUHmXfgfif4rhsCMIVbx/cdvL5DNOXut0A9W2hP8YdbkyVj/ZSOa6m5TS+HcxgLpwz0wwD7eX+WEMCq2M0bbZ42R2T9Kq/VzIHsfFoAR+kNDrR+QqK0YmOzBmYD98Fp+ocN+ngemS2JRvg82Ukq9d411kKikkYdDWgViWRMLFjO1rQ+f24wxAGTzMAOQmmLZJCJpwtkWw5NxuIqqd3wm2MTt7D639kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(76116006)(66946007)(66476007)(66556008)(83380400001)(64756008)(66446008)(2906002)(86362001)(9686003)(186003)(8676002)(33656002)(478600001)(7696005)(110136005)(6506007)(53546011)(26005)(5660300002)(8936002)(316002)(71200400001)(52536014)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r/r9CDyE9UssjqEmHq3XAVXqfQRv7bniLvoFMBSPsa1EulJDRYfK97wWSADV?=
 =?us-ascii?Q?XjdPsHG9K7NoKlAEwRyfEht6ulivi/a1xkfmw4K8IZ0eTsJuuaphs2fv30gu?=
 =?us-ascii?Q?u2Yrpb/4A3fZ8liUoNESnfh9tQJkKMBi0AdjmjhrJMFoksZ6hXy4IvI8nPyg?=
 =?us-ascii?Q?elZ50ImWyUgY+buvhKwtmHNmZn+zoGAi5MwIsDPYjr8C1vCWA0a/rDI0et01?=
 =?us-ascii?Q?zjuC8hmrbk5Y8G69sktD6skqiZW4bUki56PDbdsuYBBKX8lVGRoatTqFVoWW?=
 =?us-ascii?Q?A6m386ZOrSXTiJFDdQOJ6Ska4mXeT3h4FKRoSMeEQImrtPBtQvAu5666vaA3?=
 =?us-ascii?Q?g6AInQ0dt8lmbFLh3Lna2EwWDdAxUERuOSn2v430H4PnXL9taAOL70xToN0D?=
 =?us-ascii?Q?sCE1kBW5WnnSAYUJBuQ+CbPBAeA9xbEcQYXIY3lIJv1mPhcjXhf6UlEaTRXL?=
 =?us-ascii?Q?b2D2/yI8JJQvPrFYZyfFxB+n1njGXwk+vGX/pGYAzvnB/o6QZMooyg1gmLid?=
 =?us-ascii?Q?1FQUz5LWGfxyl2gx18+mUj4sMZAUkfJIl28LPeSSmd+jS1F8GTcV3pgPgy5a?=
 =?us-ascii?Q?d9xD6PnY7/Wcy+gBfB69Bxs8i2fGy0+ui1UOBIKat3yNyRNvnomY4ZieCgto?=
 =?us-ascii?Q?STQRa570lrMSYfplnbWQ3Yr2r1iedG8GwGfTd2vQMsDocBFNirDMJcgJEzGj?=
 =?us-ascii?Q?vnrWRtHFkalAGKtnLnqHSLqEPQ8kfbXS2L52IjQvWJfgr/EYFVkYPzKSLokp?=
 =?us-ascii?Q?bB/52Dqh1euJSinGZpy1RF+m65SpRrOF2igpTxuwWsp1exvp1IDiuWpJG2Ia?=
 =?us-ascii?Q?N67s+W63F79hIJxN5dFwiq/FaUUFqeKApPnUrIJAYhVY4Cn/CktidC0Ncbrc?=
 =?us-ascii?Q?ljcyEX8xKKPbEtS17ZfTYWFRFkxgEtg0aWiEKX0hlVuNWfgEAT0eHkk7a0F7?=
 =?us-ascii?Q?TDOZcp6g7Qt7d+pOnl6mueyrviUANWBb8T8nY28BxzCb0qG4Y8J3H5Fzmn5o?=
 =?us-ascii?Q?g+K1GdrVHVM56+W1eYlqH8hRe5GC3zQtS3ZsN/J/V+Xyqy4ZKko1lAHUjQyl?=
 =?us-ascii?Q?Rjqr++of?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ab198d-92d8-49db-e9b4-08d8c10983c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:16:28.1844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SAjXhKDg4fVpztAbUaWW4YGzC5cf1ANjpWa9NPzWE6gFIsEG+hvbkB4lX4PUUrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Approved for External Use]

Reviewed-by: Monk Liu<monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Chen, JingWen <JingWen.Chen2@amd.com> 
Sent: Thursday, January 21, 2021 11:13 AM
To: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: add error handling to amdgpu_virt_read_pf2vf_data

[AMD Official Use Only - Approved for External Use]

Ping

Best Regards,
JingWen Chen

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Tuesday, January 19, 2021 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add error handling to amdgpu_virt_read_pf2vf_data

[Why]
when vram lost happened in guest, try to write vram can lead to kernel stuck.

[How]
When the readback data is invalid, don't do write work, directly reschedule a new work.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c649944e49da..3dd7eec52344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -558,10 +558,14 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)  static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)  {
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
+	int ret;
 
-	amdgpu_virt_read_pf2vf_data(adev);
+	ret = amdgpu_virt_read_pf2vf_data(adev);
+	if (ret)
+		goto out;
 	amdgpu_virt_write_vf2pf_data(adev);
 
+out:
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
