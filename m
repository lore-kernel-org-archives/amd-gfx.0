Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D3C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA61264FE3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA61264FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3A36E9B4;
	Wed, 10 Mar 2021 04:12:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD7E6E9B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 04:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYgqi6xAFrmZh0OIUOPFSL95DTzMGyNBb2gUTpoXVtj6vv7fxvG9oB7vOTyFsi4UfUICPyzchqRt3Yud2Y84ElkD+4t2qc11hUeVvuBOuS5KmFEm6mtax4YLLlyPxkrP6rsU9xZT/s5Upq2alfw2uY4PUAriFHdp63fmguRygF1Pn7OwmMacJ8D1notENlnjJZsIUM8UoefALI7UoS2PmgsPgoQtM0JSSq1PE/wwOyFsQlyO+FSVMaVcOxabfY+oa1n0z7YY0LpkUb5RZ2aSThZC3lf8pFNFCJFgsINGYKlojXbJTrR9knYUKAT0j0VrKHLwr6yg8S8eh4U8UMtSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED9l0Yk2HZAbxWtCNWlt/ZA8VNqTQ/AB+i+7ErBhk+g=;
 b=Ne7RjRlsymxc3lQVoNB4DhMRa14iai4WG95Quufy3fTu57q7ad29n95rFTD/RERbXTHuaFJ9VbopG+6vn8x45P+Vde3t9A3+/CmtetuogKHBNCLnFQzRAOOABqNy0CuEGAKVmaS9YExvEsLxEBVezu2F+axqOKx343JBwVzB1tYA3sDlQVSo5UvBg8GgkCHd3a1+i5kPsVSOc19ySXxfpLuFR9IdTPP97faZY7f3zRwiBxtOai7jzZiXUMIdEJFjbg18DXeMGssRzBzQzdIQBqGr/J0JbbNPTm/YUD2Sb4fBs4KusTtg+u8hdBZBtrTIvRQL+HC9SpfHqGxfBugj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED9l0Yk2HZAbxWtCNWlt/ZA8VNqTQ/AB+i+7ErBhk+g=;
 b=UjezLYtwdc6eJPRH0Wws/84lc7sSGaVmhTFVEzm73UJYOm5+4c0+iW5o+ASGGeZPtypdVVrARjyejBjnr5kXJHtuqBh3cz+v//+KKRBFErZuc9+IQ1rBZQOVCn6/TgRTBwdD8SLG9gIK8NJCbyZKuGEpKqWGRORta3viiewhMxk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Wed, 10 Mar
 2021 04:12:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 04:12:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
Date: Tue,  9 Mar 2021 23:11:50 -0500
Message-Id: <20210310041150.289806-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 04:12:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 350fb98d-c11f-426e-412b-08d8e37aab9d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB479803AA145BE1D251FC8A30F7919@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vto88kPZZa46qJuUTw6njfHgXB6EM/9SaXFzgpUiFaLLfyhA/q8zV5u5OjTpBmVZHfixkN/p2M3M6El/NyyBWIXLqdLhJ5glQuSawgIuZABo+sQQvSBRdiaDuoVZCTDrXLCqX+QRYt89y9nbGy1F21MO7oQySNb0lxwDwaaJQh42gGhlcxgy/L+EtGaPbLS0M/cqKyVrqRoBmeQp4JJZ+0HBqe1s92UdfoQ96nqKMHvAfFpId++9iRHUAYod9FdN4RgNnNUWk3DxZNWbZjkGHq9vrutI07SaSr3PWPTNQ/wDE72ZnW7y5k7cbpuBmtagDDM6nBHfmc4fh7L9CdSTEQknxOU7dP/CDObbMHEWmMAzH2VK4pWX6xE+cM2KvBsY83xiksr1QyjNXEThYLP3WXUARYZcbVvhX34eIN9kqqvkCTGc0Z2NvMJO5No+A4mCgQT47qUr4NlnHTFMGN7k5eRJ69ex2vC49qMSVGbgQ/qeDu0V4lgR9cSgPissI+8WMMRs7Ri/UCUmL4Cra362fIxsBkBSzDauWg2Q/524LD6lxr4cqAuZu3lFu+gFrYvlHF+ksXIiRDhGDTQMNu0qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(478600001)(66946007)(66556008)(1076003)(52116002)(6916009)(4326008)(83380400001)(5660300002)(6666004)(86362001)(8676002)(69590400012)(8936002)(16526019)(26005)(36756003)(186003)(6486002)(956004)(2906002)(6512007)(2616005)(66476007)(316002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zch3LwcOLFinT3vitzommg6C3LV6KHbJSRMWoJfDwABC+rWLfJSf8PYy0PVX?=
 =?us-ascii?Q?+2ciyFupm8WOva3MXfT38X/2zTkbwWUE9pPncWFLLoIi3SZCMJi8Iq7H2tDV?=
 =?us-ascii?Q?HJoHvds+I/s98aks9AFmfJ3jkLOqaTrG6UDOCkhDFeRDORudwmPafYoG/a+3?=
 =?us-ascii?Q?U3WX6jnzXzHBPJPpeH5015TXV3XTV/JRmYHWVg5BAV2R5SRcCeG+WzAlSI6l?=
 =?us-ascii?Q?Tlnu3dKWyTuGEKrd9VVIpjlEi213AVU2jb3QAYysPVI9qlOtE2eADBxgCzN7?=
 =?us-ascii?Q?/s+yt+JjIritCl/5jQZJAbEzsGxuDM1gFSAcoifGmKHQpp/qp7wwfWn8umDM?=
 =?us-ascii?Q?4gmi6JPb+WdjStOPEow1c5dBdEsFCZDbwMHsSjkl/121m3vBXI4sAja3H0lc?=
 =?us-ascii?Q?aGtMU/Zu7LyKCr9hbzbh3eq4j7E+OZyOuvEk8xAPkMGl/afhf/QN/rCx6cFo?=
 =?us-ascii?Q?VgSekFnfYjOPL5yqHEyQG3O+gSxR7YSfUgan7tcgybpAbXfj4L4t43GqzBvc?=
 =?us-ascii?Q?O/EvSFXUo8dP1iW76J7t/m1n/+0vEnV9my6FPEJjsU2qxM4hYTuiAtjp5zGg?=
 =?us-ascii?Q?ocOk4sRaxlFOZLrsrhzZNyILNzFhBpmBAyMQ5bY0/ePKVP51quoIZTmrfUKP?=
 =?us-ascii?Q?spYp0qsYqKV119CKTi42UUfnQGv/KwQyZT00YrUAXfJ5+kmEWj1TJoAfEYuk?=
 =?us-ascii?Q?JYchYj0+RLkVSELIDGkX5Rdd6awcOd/ZilznUgyavulaBHInYqgb8BfG96AY?=
 =?us-ascii?Q?iLrmvBqY3K/D6G1HSMTjWPDixIg4Od1e25Wth53BqqjmilPqG2WbdjNolIan?=
 =?us-ascii?Q?+tle/dOdP4jqbcI71Ag1/vqBvwaq5yWhn0vs2Cl5zWPut5/WPNcph9BNDf0b?=
 =?us-ascii?Q?d/CmLYVvHSBlDsVnxCceNgFjgRk9ignhXs4tAsWf1FDZiGZGsnMmVJLFpvQ8?=
 =?us-ascii?Q?ZMyDsUiScIOZ3b7gSPzPfIMOkxw97evo7L9+RD9+Xr0bk7u9yc8c4plIZli3?=
 =?us-ascii?Q?H+7koGVeX/UNlAGl2qi3KTXympY6wQ9XjKjlyK5eEf6RcayiffdT1wkNPhbX?=
 =?us-ascii?Q?sHU79P7uG4oCBLNj93/mWQCrKV+vFUYoU+ypLX9yX/tomxv7sFs/vXYHJhLO?=
 =?us-ascii?Q?934NA5eb0BxBCH6XerlnRaIfjvBtR0mNhJ88czJ/e9LJoEAWuHn1FryazQJJ?=
 =?us-ascii?Q?az3eVGTOIvoaHrejrLyb80ORAEqfGmHO7o2aWoJMwvlmImJKKGN7sfWrs1oB?=
 =?us-ascii?Q?a9nqKREVpDEqv9Oriz1mfLUCiYNssPmBmiZ4vT6K7+i9H6ywV0eZt6uqVd6S?=
 =?us-ascii?Q?Y6+INDD9QM5KJ5wg4UZt0GFO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350fb98d-c11f-426e-412b-08d8e37aab9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 04:12:07.9412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhSSmeYE+t+4P59yDA/5uWFv1VS2z2QpQVvsk929efnh8oLj+rkei9D/n0LaJ+vemvREzvj6rzM2lBnjRmM+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Was added in newer versions of the firmware.  Add support
for it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 30 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
index 4c7e08ba5fa4..171f12b82716 100644
--- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
@@ -84,6 +84,7 @@
 #define PPSMC_MSG_PowerGateMmHub                0x35
 #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
 #define PPSMC_MSG_GpuChangeState                0x37
+#define PPSMC_MSG_GetGfxBusy                    0x3D
 #define PPSMC_Message_Count                     0x42
 
 typedef uint16_t PPSMC_Result;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index c932b632ddd4..52fcdec738e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1261,9 +1261,21 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			  void *value, int *size)
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
-	uint32_t sclk, mclk;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t sclk, mclk, activity_percent;
+	bool has_gfx_busy;
 	int ret = 0;
 
+	/* GetGfxBusy support was added on RV SMU FW 30.85.00 and PCO 4.30.59 */
+	if ((adev->apu_flags & AMD_APU_IS_PICASSO) &&
+	    (hwmgr->smu_version >= 0x41e3b))
+		has_gfx_busy = true;
+	else if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		 (hwmgr->smu_version >= 0x1e5500))
+		has_gfx_busy = true;
+	else
+		has_gfx_busy = false;
+
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk);
@@ -1284,6 +1296,22 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		if (has_gfx_busy) {
+			ret = smum_send_msg_to_smc(hwmgr,
+						   PPSMC_MSG_GetGfxBusy,
+						   &activity_percent);
+			if (!ret) {
+				activity_percent = activity_percent > 100 ? 100 : activity_percent;
+			} else {
+				activity_percent = 50;
+			}
+			*((uint32_t *)value) = activity_percent;
+			return 0;
+		} else {
+			return -EOPNOTSUPP;
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
