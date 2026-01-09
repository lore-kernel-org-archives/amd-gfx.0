Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDFD232EE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 08:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6767D10E816;
	Fri,  9 Jan 2026 08:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lf4S2jdR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324A110E816
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 08:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqHRfTHFWwOrIHEIRi4NzFeLZ5se3RFCufFzWD/vWG9kFWG4BxcdvHp0yAlR7rRLCUobUsDiPV97anga7qNLVeB8pFNmkR/eXHUCVjrbxpzlXYrTUhdhHxSB5m4rhVciE1C5Mn6KBpLrSJoxwf3pT+S3Ci2oErcWWlQzHDVcmcKSC1dV6f48yDioY+sNQjAfzY+QivhFqH1jWHTg0SnfOVtKER/BhQr7bxyKPmwVbdlAuQIk7B6h2qsdt2tukpMmNhAKM1+K/T4YHfsCkI5TJTtOviSqkbhop0Z/0MOThRWgP5IIeT4kwdGnwdZPT6bOCQFoumcXXIQRA93Im9tn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkp1qxEvuMg3UTazoovzGsKUc8svNuJZQeSjHZP8vTY=;
 b=fQzX5TY3hFkOv4+RwRoADpizS/+v1hvTXughOtOV6gU+tOHbB7ZEPGoVruRaD3HaHI/62ROMffBUcFx2PRf1ukoeLdJXQKFRfTCA4YfSy44G0GaGd5vzdz3VpairUKfJiY7eV0uszjTctRXSANZlvkG81xmPeLTjeGzRP4yNtMTbl7KaxS1w1E08sF3rOP6KZqkH1vuJh66JJTAdItmRjqGZENF6qO2AUT5QkXoAQ9dJM5W5mgrzm/+F6ntknuSDz6ziGK/UpkicEuFaV9rx98Dd/VUUfStInNiybM85/I0Ue20ox+QTtdEepeagkJ4MlGIPLsXoJD5sLWl5Bv3evQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkp1qxEvuMg3UTazoovzGsKUc8svNuJZQeSjHZP8vTY=;
 b=lf4S2jdR48zzm6ezmUsi6GNuJZAi0f9EDit7XYROscxQzi2HnoSdlvwWhGI5oXh8KA4ieBrdtU4L6LCEy9xSUPSjFqSDBLEPLTZ474hsGe17nTHvfPPLvvATVeVT35s5w5IYjYOfhSU8czc5W2qdN6NHrYEGHNbznyyH0fbH0Vg=
Received: from BN0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:141::11)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 08:25:40 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::e9) by BN0PR07CA0029.outlook.office365.com
 (2603:10b6:408:141::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 08:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 08:25:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 02:25:38 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, <phil@jpmr.org>, 
 Prike Liang <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: validate the flush_gpu_tlb_pasid()
Date: Fri, 9 Jan 2026 16:25:23 +0800
Message-ID: <20260109082523.889564-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109082523.889564-1-Prike.Liang@amd.com>
References: <20260109082523.889564-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d547885-009e-44dd-820c-08de4f58acae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU5mcmMxYlhhS01yQ1ZieU5kMHZOa2hFRmxLUzdBMks2WHE3MHBUM3BBT1Rh?=
 =?utf-8?B?b3ZsWDBwNnV5cnphRG1FMXRjRnVIbnJBU0VvSzZrdzlCMGVXWDgvbGgzUjBW?=
 =?utf-8?B?aWIxT2d4VndDM2pzamV5RjRKVWJXNVhLdEt3akdUMU5hVWlpOHlqNU5yTjRt?=
 =?utf-8?B?OTEzSzlyci9FMGZlbHAvNll1Y3R1eWE0ZWE0cmNxZWdRdjBiT2swNHdNZ0lY?=
 =?utf-8?B?NFpQTTFQN3VLNzlITldEL2ZHL3dxWnBZTCtob3ZOZGhtcS9ONlRFbFBKakxY?=
 =?utf-8?B?d3JMQitnYTE5R2VUb2w5T1BENlBFemIza1BvU2hZUmZJcjVkNk9HYUs1T2Jw?=
 =?utf-8?B?eEY3dlRQZWJVWmJvUnZSK0U4VDVvYkFFcUdzdTNnVXlYMmpVREdKV3ZzeWFZ?=
 =?utf-8?B?OE5HNWpQVlFEVmIrWVZNOGFQS2dySW1YdmNUbFl5MU02NTdCVFNORDZxVzV5?=
 =?utf-8?B?RC9aZ1ZJY3FVVHVheEg4S201Njg2bVZrR3o3TXdUZWlUdkRMQVhFQml2aWpi?=
 =?utf-8?B?MStoOTAyaG0yUkZiS0VyNThNQVhCQjAxMzFhTHZacVJkdkV1MFFja3BLamtY?=
 =?utf-8?B?cFN0NXRuaEtWYU56OWI2Y3NVZ01iZzJib0FNcnNnMVdSWUFtVlA4OU1YSkla?=
 =?utf-8?B?T0F5Y0FJWWhwb0ZKN05NV3VBR1NrOUlBOW9XZHR6WUhWRi80bVZpVG5JcTJU?=
 =?utf-8?B?RDJSZzc4MVdiUTlHdXdaeDdGTmtTMzFTNjlxdnZQN0hFNTRiRlYxdjQ0Z0lK?=
 =?utf-8?B?N0h4bVpTblhZaDZKdGtLSzVXZDh3VUNwN3c0YnhUYTY1K283K2VxQ0lXM2Ux?=
 =?utf-8?B?THgwMzAzaEoybkxiR2Z6a0Y0Q0J2c2hhK29VWUkwSzYzYkJRR25jSk5Zb0x6?=
 =?utf-8?B?Nk95N3dPQ2lqRW1PeDhzWTBWUlZyRjZ6NkhCK01wZzFyYTZiZnJBbEtrclJ5?=
 =?utf-8?B?dk5vNHkxWWh1ZFRWTG9FQ2YxZFhrZnQ0S1k5L2lHUERhaElvek5XNUlwZ0Ri?=
 =?utf-8?B?aW5uSmxvWEhHeEEvSDlWSERvYUI4MVVvUEhhMW1kajFyZHpsMkwxcnVPYWtr?=
 =?utf-8?B?RG9oazhQNU5BMXg4Skpnc1Z5L2FnRzdBME4yZUwwWFhaanFpZ2xKSWtyQlpZ?=
 =?utf-8?B?aGkrQm9VZlA1TWN5aTdVcUVkVTc4S3B0UU40bWxGcFo5aVJHeHZOQ1BGK3Iy?=
 =?utf-8?B?dlJqcEsyUXowYjV4UElPZWtIeDhodVFtbjVmdFpiUWhRWU0zYU1xNTNFMGZm?=
 =?utf-8?B?ZTRwY0pXbTNhbEdvekc5UkhxcE9SZzVrcWI2eUZoS1FyaXREcFliK2ZpY1Vx?=
 =?utf-8?B?cDB5SlZsdG9BM1g5clYxSzlRSVRmTmYzSGlveFlsV1dnbUtva2hMYTluc1Bq?=
 =?utf-8?B?NlhJU2g4ZVNVMERIT2FBZ3lhSnEzUk0xWlRaWmd1MEFtQUZyM2F1U1gwZHZF?=
 =?utf-8?B?T21yOStTTm5PV1NZelJHanhmeWNGSENwMWFOazVJR3YrR3ZZSks0YUtCVFJW?=
 =?utf-8?B?TmVEZGRza3ptT2RSYTJFT2o0UC9uYTZEdHBKSlZFcGp3Zkttc1p3MkNhQlhq?=
 =?utf-8?B?UTJ0eldDcHVIZ3hrY2U0REl1LzVVUFRtWDlKaVFoQi9CYXNTeWF1bmRMbFJV?=
 =?utf-8?B?YnRqQXNwNC9jZ3FGQmluam80Skk0Tlk0MUcvOUh0eVRoRU1qTTVCM2hxeVh3?=
 =?utf-8?B?ZFIxWUthM3E5Nmh4Q1RDMGpXR3FRdmtNSGoxT0F4V0lZbEo1VDdBbWg3ZnZy?=
 =?utf-8?B?LzlzSGlvS2ExQnpnbDZOVUFjUkswb3lucGdZT0d3OFZjR2xwYkRUSk5nSlVU?=
 =?utf-8?B?NUppVGhYdThxdWRBYXJzNHRweU1iWVFrMVRwc1N3R21VUElkTDBldDFvTW12?=
 =?utf-8?B?SER4ekc1ai9XWi91T3lGeDJ4cVNUREl5YjlZZmEyNE9rdGtmeHV0WlYwQjhx?=
 =?utf-8?B?K1l0bWxhQVlPWWtnVTFuUlcyZzIySmVJRks2WGlUY0g2YlVXSzBiOFNYb1Vn?=
 =?utf-8?B?cnlvNmFIRytScWtsZkNUVlJoNTF5YWptK29leWtTWjc1L1J3ZTNidWZ5Uk9n?=
 =?utf-8?B?TnB2Rys5QzFyeW12cVNqZTRqak9OYlpUaEFXWTNkQVBmSzdmalZGNmtqbUR6?=
 =?utf-8?Q?dxcY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:25:40.5601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d547885-009e-44dd-820c-08de4f58acae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
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

Validate flush_gpu_tlb_pasid() availability before flushing tlb.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6d7b8bb953ae..0e67fa4338ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		return 0;
 
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+
+		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
+			return 0;
+
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 								 2, all_hub,
-- 
2.34.1

