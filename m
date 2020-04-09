Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B41AC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 04:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E5D20747
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 04:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PI/iEbYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E5D20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AFD6EB40;
	Thu,  9 Apr 2020 04:14:43 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2756EB40
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 04:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGtQBxoruQ1yge/8uMhATsgPUxJ5eYxdRdk4KxkFdlvB030GFMosB9eIo9igrwq7o8N/gC2115yoRvdhp030xd6ptHnUWl2VO1V8dI8jt6boQxX8Z5R7Z7/4ascyluW1bnH76Kg8oDcfrVNGD1e6UePQKXMpe77MOrakiHOyOcHmFNax+dPi+uDHp6MDuINbgIYc10UYdlZNtRblca+RuToHZbDtKkIb/wIB7WaXeb6FGQ8oa5FeVq04EYatv0seHMiG2cnObO/OdwLu+3KPuxMDpBmazYWCEjecnCR8J0mdf9S8UcsGRStkOBDykgprKVmK83iD+A97SVNqceOtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ky9JEfamBqxFva1G+V9BiGrhqE1KvwcKLcUxzPr0BI=;
 b=KGIuLQFVU7wa/rcN5CL2udqyRgU+E0QkfRPA0okQWPBp7t+s3tfg63jCRrlqguGpobrokF622D5HPq6rAH2Er6d7H650SrmB6pz1ix7ihLU+B07nBahME4FQp1WRagbHdDkpRx7MSb5BfoTOeW/oJ3Nhd9G5FCQ1bLCw4pp+W1YMLU3jUnIhjcXb2nwuVm+6twyMXkzjetjAZrvKT7H8j0CfeHENHRQUs/5urT0SGY63WfHtFmB4RioOFomv8TBGDQDN3invaucJF927Soj/Ec4HObQ3bmDpjtM2y7fq5+Pz2XrBsHwjBt4IHhAE2KWW0mtlL9qaAWF4Pfus3dZ38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ky9JEfamBqxFva1G+V9BiGrhqE1KvwcKLcUxzPr0BI=;
 b=PI/iEbYXNWBotPkE1/kEcmBU/at5r+WignsgJPnDGF/xGnblYlisUb6Ai2Fta+TzHsn7JpkKIg5wQ9KF5Fx96wwFPjFMvfY2EQt00Zzi7fv0TtrzIprj3Grl7dH97KdgvSvo5jWz7W929/F1EX4u9b/C5u4MwAE1pDoUGZXmw/o=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17; Thu, 9 Apr 2020 04:14:38 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.021; Thu, 9 Apr 2020
 04:14:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: change SH MEM alignment mode for
 gfx10"
Thread-Topic: [PATCH] Revert "drm/amdgpu: change SH MEM alignment mode for
 gfx10"
Thread-Index: AQHWDiUqBKwc0xCcz0O+yj+LobAguKhwLmFg
Date: Thu, 9 Apr 2020 04:14:37 +0000
Message-ID: <DM6PR12MB4075A698C9C5D624C4CB0B55FCC10@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1586405570-11485-1-git-send-email-likun.gao@amd.com>
In-Reply-To: <1586405570-11485-1-git-send-email-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-09T04:14:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=90592400-6985-4f8f-8574-000044055ff4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-09T04:14:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 76d94739-b74a-47e2-bec2-0000145a8d91
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de7309bb-15a0-437c-f9da-08d7dc3c84d4
x-ms-traffictypediagnostic: DM6PR12MB4372:|DM6PR12MB4372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB437215E3CC7472094557435DFCC10@DM6PR12MB4372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(71200400001)(66446008)(64756008)(55016002)(478600001)(66556008)(66476007)(76116006)(66946007)(9686003)(2906002)(316002)(53546011)(7696005)(6506007)(110136005)(33656002)(86362001)(5660300002)(52536014)(8676002)(8936002)(81166007)(26005)(186003)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETr3w1Ri8IetR6CkkoZ36upCiuBieVzPRy6BuytoK4x5fso3fpRq/jIAL654+JVA9tiQHLmyHNyx2XM2snFBZjNKhWhiWwoghtphkbBGwoHau/dlcwVXqiEqokpyIimVIeXdWotomzb8drNprYi8U9akUtU3EVlqVyR1IZ/7Nu8UZuVJDn3tP+axcB8/4uXqKTvc9EaiSXjbGafFOQs/Fo4vjDndjWPalQ+5nxdMt77fHSd3oPjvH4JpYETUxmJtTi3/XTr4reTwK6uq0hIQYJDmtG5nCILY6XDljrEmmXhNsZz/V+R1c3LYID18PyR2Zrk+vx2QzbgpsFPrdRXbWGOvAGIi1c0jOfYbi5QDaBX1qV+m7R3S+ZgB/gm6jBxmE8K9C3sa4gFQhoN6Xb2ZF+Ek2RLAo5ruS6EwU9AIr/7MzQmwiBAGwV2yYmhvZcL1
x-ms-exchange-antispam-messagedata: MhdWb+s5vZGpcxZKz72f3LrpAK2+ZgckhUj/G3RhDuYKvuxgI6mdudWX3BuZ4zPqFOEctB9S1wA+1CacgLIJ7LD0hoau0k49HIhkJgeRxYYPLybGvJ9z+m1uc0U6UukmAOuYQ80xZ/IMFYrNkdCC+w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7309bb-15a0-437c-f9da-08d7dc3c84d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 04:14:37.9479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVDQy2EQX3gN/QY2KCBLSFLArolpUqgW8FvRxK3vKalQhm60UtvUL0Yx2/Ra5aaIQDHDaMbDLnFMifIF5b1VCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Thursday, April 9, 2020 12:13
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: change SH MEM alignment mode for gfx10"

From: Likun Gao <Likun.Gao@amd.com>

This reverts commit 8d2afe375f6ed9d84ddca234d49a53cf875f9042.
Revert the auto alignment mode set of SH MEM config, as it will result to OCL Conformance Test fail.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 29c94bb..0a03e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3015,7 +3015,7 @@ static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_2_nv12[] =
 
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
-	 (SH_MEM_ALIGNMENT_MODE_DWORD << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
+	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << 
+SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (SH_MEM_RETRY_MODE_ALL << SH_MEM_CONFIG__RETRY_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
