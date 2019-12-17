Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB3C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 04:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F382146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 04:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bpy5bSZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F382146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A554E89AA2;
	Tue, 17 Dec 2019 04:33:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F51C89AA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 04:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0X+qkDPMLsqgT2t6lktidkl8cDNXcl788WMMwf6DV3EUf+G6P3CphiazvIAFn6+UId5kcIcHTtF0g0+Ui8Wp911YNZQ31ar9tk9SRWiFA8ICF8rRyw1iP/dNtIc2PlUlqeglgwwBlwmljhBkGIAOPH+R6f5KRHKzfDSMllzbuO01iqO8m7rE3uQXZwozvhBi6FOOywVXYw0oMmOmVNeMc6ZTeMHtV/RBgzuSASM56rduvUgOPoFfeXCUduv5j6ZvAzdyHVauMdHmN5PRfkeXS8ouD4AsZZH/v0VP03CDUgB8OO8NxfDFcSOQ21b4pTmxyI9Sxkya8LUG/c+us8nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ExTyYy2x34eqziG/7bWHburS7QSNw4Huov/aP4TNE=;
 b=DW6FlxTmYserMeQXWvVNeYYqcPmrNe1+szG3vziv6yh54GlWVovaBVqOF5K0M/FzyRNnczhS3mHL0l2Ls2d5r8YuPiIhfSDVT1T5VbBZ24/hy74nZ4aA6cV+dDDsx0S3+cyc56vHodQo29Xdg7nXjz2yzHA8e5X4C1H0nH9fz2VE7aZ/P8sTVWbMh70M0pbzCgAAOofVC+1oz3dsACkQoUlzpslBdPAXtwRZJR1H6yLx+xcJ3fd2blj7jKThSGt195SkLFmT3B9wUV9Aw0E8ubjQYxLzdzZi81tdjkBB44biKijDiQn+Y950Z31yka5Y0YTfCQOoXQ06zOe8WkcksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ExTyYy2x34eqziG/7bWHburS7QSNw4Huov/aP4TNE=;
 b=bpy5bSZVA6CzsrEi5/ye3LHGIzAq3KPpUhf+huPHe1qf7FvOMC7n/keF4MJ1Xlrs/i5ODB6ten+TxPSr0/zSZ3X8nI427DCwWIaoDN0nMoj3pvqY7JOZ50SFz6x1FWpTnNfcc4Z/KFZB8GcpZatSuEaKngK3WrQTPetK8SABHzo=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3246.namprd12.prod.outlook.com (20.179.81.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 04:33:03 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 04:33:03 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: skip soc clk setting under pp one vf
Thread-Topic: [PATCH] drm/amd/powerplay: skip soc clk setting under pp one vf
Thread-Index: AQHVtIy5QM1xkIUzaUWDYMYjV36PPqe9vPfQ
Date: Tue, 17 Dec 2019 04:33:03 +0000
Message-ID: <MN2PR12MB39338C75A32B3BBFCC55B85984500@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20191217034709.21719-1-yttao@amd.com>
In-Reply-To: <20191217034709.21719-1-yttao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb66fa75-45bc-4813-951e-08d782aa346d
x-ms-traffictypediagnostic: MN2PR12MB3246:|MN2PR12MB3246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32461EB94454451078E6501584500@MN2PR12MB3246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(13464003)(5660300002)(52536014)(26005)(8676002)(81156014)(45080400002)(8936002)(81166006)(966005)(478600001)(9686003)(55016002)(71200400001)(33656002)(2906002)(66556008)(64756008)(66446008)(66476007)(66946007)(110136005)(316002)(76116006)(54906003)(86362001)(7696005)(53546011)(6636002)(6506007)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3246;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iI32lRlPxvJ7BKJcg03cGEldohCRz5eQ6cVNuDW8eGknDyj8Gdg+xApGo6L3fyCSRQMxJTeIl83pkFA/XV0ZLbaZVHz8mAx1J28BtGg4GE8Mx2EoxpbrSuT+a81s9xGbOv+/8GYbz8OWh7egyZskPggs25BNnlewgk+8K4pGZVM6pd1gaWgXx04WzXRvvOplzfF5txtGWMJWLZbreMtqSTZOzRH2Vur2SnYWFPp+sDqHNE07b5mf09K0pgrHUHbsxbZ80xt0PU0IbmbeQJbvhH0DrX0HVhbC82EkrEnUsiCKyfKr1DIW7oomvvZ7fcflnMkJ81DqF16qXA3LbqdmX0UxU6HEDvocPKAz3ZHaPiAB6AfqL8F+N4kOf1fKplKcMkA9uCW+WUXAIos2zUmHu3CA4qA99JfGx1PVh/NsPsxLWKUFDA+6wAZZNqo+cWTiS4ZCXupuMOUt1eflGaemAz0icbtjdiTA3w+gLDw3L/8hkKf73gPDP8Kv6XBXCRczblYejod5auB04jonnrlpuB5YlpuNMHAMk2tJSnUuKAM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb66fa75-45bc-4813-951e-08d782aa346d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 04:33:03.1222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jLB+d0UGy+aDZGaUCyqvz9PwBOU63p9LreRMfCa9hTCqWOkkBgeohSu2IY90pe/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by : Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yintian Tao
Sent: Tuesday, December 17, 2019 11:47 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip soc clk setting under pp one vf

Under sriov pp one vf mode, there is no need to set soc clk under pp one vf because smu firmware will depend on the mclk to set the appropriate soc clk for it.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 148446570e21..92a65e3daff4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3538,7 +3538,8 @@ static int vega10_upload_dpm_bootup_level(struct pp_hwmgr *hwmgr)
 	if (!data->registry_data.mclk_dpm_key_disabled) {
 		if (data->smc_state_table.mem_boot_level !=
 				data->dpm_table.mem_table.dpm_state.soft_min_level) {
-			if (data->smc_state_table.mem_boot_level == NUM_UCLK_DPM_LEVELS - 1) {
+			if ((data->smc_state_table.mem_boot_level == NUM_UCLK_DPM_LEVELS - 1)
+			    && hwmgr->not_vf) {
 				socclk_idx = vega10_get_soc_index_for_max_uclk(hwmgr);
 				smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetSoftMinSocclkByIndex,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cf68b55e2c84f46c5661008d782a3d41a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637121512578220813&amp;sdata=1dozz2B1%2Fut01nRqOpWkMD54WJuPA3UbVn%2F1OaKy%2BIw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
