Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C75C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F42610E270;
	Fri, 11 Apr 2025 14:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIgIRDB9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7421C10E270
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj/5QtSapaZuBBWZbHABecgBAMIoq3CG0lCBNLq/l8BonEXgtlevITZuOzWjRa4m86XvJB3CJKBmUbtkGQjSClvfykMGEf1fpTGKxNyBwdMv+AM2VLybUJt6PwtibBu6FIaVmfNZEEdU3MzaqtzpgTML+fn3YFRr6yLn3PP+60Kv2OTOd5vRYGRXV1lk5AGwo/BMs5FOTVeyJiMjSr8WA/WqBrH6TEhJIwgzn9iDon5Z21Eeh/wCEULvrDt9TSdL5naFFKmTTP3c2I1N3DWFjlvuVq0g3eCQHVY1dBtKniLx9vkqugxHRlKG+o7PG4GMXpZIWQMzBPCukI1aWQbKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsbRI+PpPlM7sLL+7UOa9m5HjlHgx6Z4VAClY/SDuUM=;
 b=X1M76nSSsg6StXFd0YYVhMKk/1AcyZM412msWFzxNQQ8J8xYyKfRc2p+S3NAMSzf4YJAlItPp6q05MRq8cVcnhmY0vkPahFUGCsxhXhC5KaNFdqbuK0LyGZlkGNFlH0AwmeHgb60Wua0GHzr2dEueA8bFlDkxdp54itoY1j8doKKhwNUvucMrlZbMPNcrPg83AYKbuzC6y9wP8sBCZ5Ll7aV2YzH1MvK+x1rjStl7LsonP3nk8R3sGF98qVk6msz/49drKgsZwfZojoKWqB8m1gdfjlyaJzdWc9hPJNwAqwfrlwzANgYE5wwWdTg5y9R68wglx17/oj/FR4a1olEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsbRI+PpPlM7sLL+7UOa9m5HjlHgx6Z4VAClY/SDuUM=;
 b=xIgIRDB9MvL3hx07wNqd3U/u6YZl2Qf2Wo18VopWv4DslnKH222fYGbTVUhfTXlPBXgppyva7/NkTEB3vDIX5/FWT2Be/Y2gHFfQFRQW7+O+kxIfarnXdDK6eJcv7HDe4gCugEbMocbez5rp9/+V2tgRJKSaokrK/JMMGdV+0bw=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 14:20:23 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::d2) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Fri,
 11 Apr 2025 14:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 14:20:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:20:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: replace a comma with a semicolon
Date: Fri, 11 Apr 2025 10:20:07 -0400
Message-ID: <20250411142007.2742502-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e89ac12-60d5-4a72-61db-08dd7903ff31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFpoZjl3K3cyUmpRL2ZhOUdCRmZZaVRaazNpWVRkNDErdTNCUVJnYzFDQjF6?=
 =?utf-8?B?a2JkQko2V0twM05xbHVlRllDZlRUQ2F2bHZ4SlBaK3ZLUFBPRkd3NVl2RFFR?=
 =?utf-8?B?MGZncjN0YVZkL1N3RDBsTnE2OXFpVXZOcFRGRERJQnRDNlRZdjdNNitRWjJa?=
 =?utf-8?B?TjZpWENLclVlUmlyK1M3eW1nRUlVVmh6YS9RQmcrcTVsZHFQRXFldGxkV2RZ?=
 =?utf-8?B?ekFsR2JjYTlQN2VRQU5ZTjdRZENKSk5LZFJmTXp3MkZuU1V3VG5sZDdBN2sy?=
 =?utf-8?B?dkJKWmdkVTRobXFCeGRNTFJOMWlUVUtZaDZneGtoNHZORnpyQlFNK1Y3OC92?=
 =?utf-8?B?ZFdVTnlTRmxqMDViRzdBdCszaWtwVEIvODBNR3JDSk9zRzZMeTFCZXdJejdJ?=
 =?utf-8?B?WloraE54QytEYk42QTFReTlVV280SU1YNUFxMGR4bjhpem9Mdk9ZazBDdEpx?=
 =?utf-8?B?anY3bUh6MVNJbStVZm41bjBiVFFrb0JOZnZhQjN1NVZ6VGRDeHlhbnpXSkxU?=
 =?utf-8?B?QXdmRGF4ZVk5ZlkzOHhQYVdPTU9DdnNGcVY1NHJQWVE2NmZnK3pPSUJRdlBy?=
 =?utf-8?B?NGZ4RWptaXhINnJ4K1ZDTzA1cm1ob3dxN1NBYno1b2trWVZPdWwzMXBmQkpP?=
 =?utf-8?B?YjZqNlFBb0dhNTJtVDY0bU1iaDZxVmpjUG1mcDEyMzA1NXpwVWZPcTZmN2VR?=
 =?utf-8?B?alRaRGJ0QjI4VWNoRVN3bHlrT0JmOHdFc25sRmhxTlE1eXhFUS8wNld1TlEx?=
 =?utf-8?B?Qjl1WS85YXNJakpCRGlPd0xmaUNnK0tkQ1R5WUVUSVFQVmI1UzhoNFBBK3dm?=
 =?utf-8?B?MWpYem5OQUpsMVJUTGtZcW11TU5EWkNPR3A4clB0d3F1MUMvcHZWQTBRd2xa?=
 =?utf-8?B?MWh0YmxNY3lKRnJtcXZ4aFJ1WFhPbENqc0EvVVI2RHhMTlhaejNSam1PbVYv?=
 =?utf-8?B?RGV6Nkk4dStFbU5zR1huRSt4dlg0ckZMbFlaQ2tOd0luajFWN0xRWFROSjJt?=
 =?utf-8?B?aUdZSUlJZmRyaERUckRzRkJldVcxLzlWSHR3SmlVNWpZcW5jRG1iaEljaVkw?=
 =?utf-8?B?b3dSVjd1Z2cwTFV1ZHpwTWVKdEM3Tm01alZuTGhnTDBqc2s3MUZGdzBUMjkw?=
 =?utf-8?B?UmlRb0lQWVRUZkcyVGd0QVM4YU81Y0NEbUlsNUNDeDBoeVB1aWxCeStXTXZV?=
 =?utf-8?B?cmtuVHdiZ1AzeWxpZm9vVHpQQUFMUlN5amg3M2loR094a0wrVDlHeG1jNENz?=
 =?utf-8?B?Qnh0SUYvM2ppRmVsYno2Vm1zMHphejRuZUc0YmVrc21xQXNITW1oYVdrcHAr?=
 =?utf-8?B?ajg4a1AyczhjRHNmczQrMVhENUJnWkZ0V3lOdXl1ZDVVM0hXUmdNaGI3bGFv?=
 =?utf-8?B?TkJaMFlZYWlrR3JvenJvczI1MWlsWjhJeWEwa1Zvelk1RmNqek5DYjdvaVZx?=
 =?utf-8?B?ME0rQzIzVHY2VFNucnAxVUN0WnV4SlF5by8yaXlXYzJQWlBDZ0kvcGFEMEU3?=
 =?utf-8?B?cTJ0L3AvL0svTkFTbDdDNHgvb2VRcHBpWElZZE4vV0JpTk5IRmNQSW9sQXVp?=
 =?utf-8?B?UG9sbUFnMC9mQVdGazFramIxNGlPcHB6QW1namVVUmtNVUppTDk5Rkc3VDRW?=
 =?utf-8?B?RGM3OFNIRzhLeE1MbWpKa29rVEM1M2NwdVJhMzVlaFNRaXVTRDNEK3RhUDdK?=
 =?utf-8?B?WmZGMis4WWdwUWxScmpPS29qWHllN05EcDk3OEFKRGNTdjRrK1lnemhqb1Zt?=
 =?utf-8?B?czBKNGJmM2RRTnFFUjMybjZjd210a1FCTVVEUUpFeXR0dW81T2x3KzZCWFNk?=
 =?utf-8?B?RWhseEZHRzk4NU4yU0QyZmxpbVJtOVVkZVo0bXZQZ0FYdVhNLytOYUdRWHh0?=
 =?utf-8?B?M1FtMStrUXJzRFp4ZmxCTHNJZmZobHhCTjlDYm9DM3ZGcHdlNW1nQWFHanYw?=
 =?utf-8?B?NDNQVllKVHNHSEZvTkMydlEzaDhWdjRRYzRnYW1Wa2s4RDRHOXN6SlkyVjhK?=
 =?utf-8?B?MThNQU9pVWxIb1dySkpPcTJWUHpROElVdnFYNkUzUm84b2c2RXNpOVF5ZVdi?=
 =?utf-8?Q?1WfBgR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:20:22.8205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e89ac12-60d5-4a72-61db-08dd7903ff31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

Not techincally wrong, but I think a semicolon was
intended here.

Fixes: 6cc6e61788f7 ("drm/amdgpu: use a dummy owner for sysfs triggered cleaner shaders v3")
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f1b87b177f4e3..c206c3b371ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1460,7 +1460,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	 * the cleaner shader on each submission. The value just need to change
 	 * for each submission and is otherwise meaningless.
 	 */
-	owner = (void *)(unsigned long)atomic_inc_return(&counter),
+	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
 				     64, 0, &job);
-- 
2.49.0

