Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2B5C0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491E510E763;
	Wed, 29 Jan 2025 08:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sq8+niyW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF1D10E764
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFAweGw7XC3fHYnQMiLH8AAVUY/ddRBeqE7J5b07LdDk2jqCyv4TW7uYxxbtmmtyRBWcmWrwKBwcTPn9xYRoSYrPTiyGho90H518g6AjURnTePphm03blaFiBhsdt7glVV/pmXdmdp1Wqtl62EOYLzpmjCHEyqN06loPcuSEeYFXVhffuvqu+MSPYWfaBRpwup4O3liwdnSx1L02otYE5WOXvY6EmpM/uGH47IXiNckeYhzzMt+ST/WAIi7oUxkukbw5nBB2ywwVv0h08wr+G5rBUWR1NOHEFValh8uLL6mbT/YEd7EhNk7A/jxjSJ6ymfUmDHQK82RMYmQLK/U8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP8+xL4FiNdCUbjcdhm1sEHzMj4hFSOoqZnP0BzPJws=;
 b=CLUEldeO8TbZOVLTzYOd27wLseHWbw1kLpXiRa4VjAA5PwxbZExTLtDmIibZY4SWRXI0F9HGlz5T/PY8GcIjr9yepoQKXK9baXYDTbKI6zVnbGS2K/A4JgrNddUc9Lw4dpSUbYCiSATpgvGr1clQm7LkC/F3nRsg0SZoagOFXT8N9pxit4g3FUTuEg+OulPcFypgIiSzViVj7qKd7daJo7UTK3eE4kHdOJYXgImSOKRO2HvMUTu2jY/5OYOa6uxdlq6MLX+LVe3hVrAG3jJPOkztDY8RtJrQW2v7fgxclfGXQRU0vSh4cip7eMIV9hHAfT0aA7cvpSRgF81vv+AulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP8+xL4FiNdCUbjcdhm1sEHzMj4hFSOoqZnP0BzPJws=;
 b=Sq8+niyWRrM0JtcGN3q+NzYLLt2zzONX0XQ1BGeMm475AG7U7sUTdkLtXooH7fpkFfyjBJboz2vTqYVSRWu74RhH9i8n/v/GYTznbM98PAxFg33jibOLKZW3FI+L34Z7YvGuyN8OFkCX7ZaHDyYZQzBr1X1PtRtLdjBYCW5fdHI=
Received: from CH0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:610:e5::17)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 08:47:51 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::af) by CH0PR03CA0252.outlook.office365.com
 (2603:10b6:610:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 08:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:47:50 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:47:48 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 3/9] drm/amdgpu: Enable devcoredump for JPEG4_0_3
Date: Wed, 29 Jan 2025 14:16:37 +0530
Message-ID: <20250129084643.507727-4-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dca1fb-8f08-43fc-cafa-08dd40419ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUx2N3dYYWw5WEVKRnNXOVF0RWs3bmMwczVqN21ZQzk3UDlrbjk4S2ZnMDdv?=
 =?utf-8?B?ejRkeEp5RXl5b0pzUlpySW5jNDFGamYyWTZSWVJKMTJYRkZsSGJnVi9tendt?=
 =?utf-8?B?WnJDZ0ZRZ1pMRHBMd2NxT3JCUUJNelVwc0paa2pJZ2N2WW1sOUM0TDY0RmZH?=
 =?utf-8?B?RFhpSlRJa2Jla2pKdDF3d3QwREZKNFQ4eWtscFV6ZERhbEZCTVRGV2M0OEtY?=
 =?utf-8?B?c2RZRzdpODNRMXRoeFBTMTd6UUtCK2NtTjJsM3RmdzUwM0g2NjdvWWtwZG8x?=
 =?utf-8?B?SUswNEY0U2xFaUxZaWZhUTY0SEVCVm1xUmpnSzBoVGl5RndRVHdla2MxZVV6?=
 =?utf-8?B?SFNyKzJtc09zL3ZGb3FhZm92c0QxV3lJbTc1cFJ1VXpmM042RHk2VlBNOU1Y?=
 =?utf-8?B?VnNPMjgrcDBZRE9ocm5QbWEvdFg2RTM1ZFNoWU5mOXhMbVg0dE9aZ3Q5dFIv?=
 =?utf-8?B?eFdBR0pPVnZFaERtWWhZSjE3Mzg1akxjL2FaNi9QZEorZkFWNDNSNWpEY3l0?=
 =?utf-8?B?QlRjRnpnYkhOUE96MDk1YkJFS040RkV0NnE3RjlPSmV5RGdjOCtsRWFydWEx?=
 =?utf-8?B?YVpmOFNYeGRvcXVtNk9wZ2RVNUJxSHdqNG5vWkVsSE5ySUo3bERTZHFXdkRu?=
 =?utf-8?B?VG91M2xGSGdONVNVSWpqZHZNa0VFcmVXTlpxaCs3ZzRkSWM3TGNvOFZRcHZU?=
 =?utf-8?B?YmZBVFV4VDBBRkZkRzFhUGIxQ1B3dEo0eFY2bDhOWmFPVldsc3lUMEozVjlT?=
 =?utf-8?B?QWZTVFZUbVZpbHhJTERzdTVmSXNGU1o0WkkwV09YOTUvZlZvaksrN1phYzd4?=
 =?utf-8?B?RjFZeHpHVno5Sk1PZ1JhQllXcEpuamQ2eWNHcGFMVEVrM3ZyVUwrWWxDaTlN?=
 =?utf-8?B?QWxuSFdKeGMzdEFNSW91QTk0NVl2alljN21nOHRCay85VjM2MXlha1Q2d0hw?=
 =?utf-8?B?bHJEQnZaejJ3eDU4ZmlyTVBTZjAvNXMxSmZMOTlmdGRyNi9sOFRxajBFQXFY?=
 =?utf-8?B?QzFvZ0FOQmFUMStWOWVTanZ2a2lXTlY2SC80V1ZkbWQ3RVJKMTFyVWs1NGln?=
 =?utf-8?B?QjU0WVg3MFVJUkF1ZWQxRG1WQ3EvSnMwSWEvZnR6amNKcTgxRDBGcFVnb001?=
 =?utf-8?B?ZVpyY1lsSmUvL2VneFpJaWxLUkYvWXd5OXpmZjhrdmlqUkJSc0FXTTJ4YTlm?=
 =?utf-8?B?UjRmQVVxbFB6TzZhTjRYN3pYdW1Ja1doY1E5YU1KRTFJOURRN0svQmxXeVlq?=
 =?utf-8?B?NzJqN0ViKzNSbFNhL0tRSGhZL3lLemhmZE9Demgya3M5NUhQeEVYMVJaUTk4?=
 =?utf-8?B?WHMxVFZQNmlhU2pyNmRqYnoyZUNGa1dZcko0V29ZWXFFdWlnSDVJOHVDM0lX?=
 =?utf-8?B?ZW91d3BTVnR4NVhiTXpxb3VqVndOaDA0NFh5VXljL3VBMXhVOUdHZmdZVDVj?=
 =?utf-8?B?amgwMWtmam14SWFQNW5BU2pXNDlPcGlvWjRMcENHMkg4ZjRaRGhFMlBYaDFo?=
 =?utf-8?B?RGhjd1RxM0pkNzJSaXZyRlF0SEo5RUIzSXdHekc0bFpBWXZldGFLTld3WUNa?=
 =?utf-8?B?ODBKMlA5RlJxaGsvRE8rUDgzUTZDQTFWSkp1VVVlb2JMbGg3V2V1NW9acVBJ?=
 =?utf-8?B?OFRZV3F0YkdHSHpxRHNCYUcvRGx4NndxL2lxM0pIaHkrYjJLdm9OTk04ZEpG?=
 =?utf-8?B?T05XaGF2UUl0U2s1WUNrZ0JPZ09mWkt3L0hCUGtlYWFBKzAzZWJBYzR6WEpU?=
 =?utf-8?B?cFhja3ZqbU1TNi9VakdOckhNNTYyZEVmZjBEeGVzZjF3aXJUalF1Z0d6OGVt?=
 =?utf-8?B?YkQxZnlVVUNGSTM4SnBkOHUvUkcwekpCbUs1NlJlOEVYaERiSW12ejd3bGN3?=
 =?utf-8?B?ZSswWHIvYktVYXlzVlJBOWRSVTNYWG1sZEVoN0o2a09CQlVUTDZUbnNycmNS?=
 =?utf-8?B?ZDZnUGZVb2RPbWg0RjNiRjJ3VkN4MkhXRUE2dVNCeEcwcytJcloxTHV1b3dl?=
 =?utf-8?Q?fLJgAWQUqTWFtm1kc1poo/CdtT2MjU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:47:50.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dca1fb-8f08-43fc-cafa-08dd40419ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add register list and enable devcoredump for JPEG4_0_3

V2: (Lijo)
 - remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index bc21f12daea8..6fc466af00e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -59,6 +59,42 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG7_DECODE
 };
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_3[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_SYS_INT_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+};
+
 static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 {
 	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
@@ -164,6 +200,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0_3, ARRAY_SIZE(jpeg_reg_list_4_0_3));
+	if (r)
+		return r;
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -193,6 +233,8 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -1066,6 +1108,8 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
-- 
2.25.1

