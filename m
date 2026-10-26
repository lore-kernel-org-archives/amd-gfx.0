Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3D606A321
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5sH/ITi2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFE910E813;
	Mon, 26 Oct 2026 03:21:40 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3F910E813
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksbQTtL5OvSdgniKmR5B2Bcs8UzRWJtD4KTMHUV5ztjC8bolXB/vgPqbS3L8gIm+81q9GQfNH/VOyzInHIaIQCtP6xv7wUmEEji2SCp7WZbAlqCb1ibBVNSqP7+0kfklK0ANzkkMtCGwbyjlNW4gSnCZdFTLGfcULparSTMspMUseQBOLBEWYlErWLoB4aJlkqD6kT7Bw704BszjFmlo+RnrhQr59s1XbpbXq2++55j6aZl+qeY9mDM3z9pbBjoL2xHPQXS/OhTODFwe9Jt851W8dUPzNZ+spKkue6A91YDMzqgHUHlIqB86J1WIxjnbyz2pfZsLOC/SYcUi4aVIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ch06ffhUEG7Z3gu+a7aIHREV85wEJe/mi5FNmcNoKA=;
 b=M7G+kL335Rm+Jh7DN9lFqX09MYOPXIRQ23GvAhO6B21bkflOrek7ecWdQKKCRyoV4fyrBPtIOhS0dFm0e7UhbtPVphCYlcxlse9GG59+xnClJ7k0Apn0uQSpRr6ZyaNyVnZ940WeycYQCeRFZJMh3A+oZ5yjgN8PaU+emw5aQlYPqw0LU4n2WYaxLG1sdGBYs/K2H5jd4AjlCF1hfp6fZVjfhDlUVbX24rsG+54cv6pZuG90mUZrxlPStO6o+TLgJdWyMheMj2wjgeqPzb/+IdcFlkJSqnkMea/hRKeWUN6zUJeDXUKkzkKJ6XDQqZtZjamRx2ECRcy1zC4ogWN3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ch06ffhUEG7Z3gu+a7aIHREV85wEJe/mi5FNmcNoKA=;
 b=5sH/ITi2eMXruzoZg8iVNDETvaxak8WEARIyB1eSm1ldt1SijJ4q4Evf2toDe2CQC2B6tSOioNUM31hr7sUfzNqrta2kroSR50dJZDuj32qks7fLyKmsXfwlpTjvxXnkOAhXRB75w2YRO69LYYOeTwZiKCgyNu08NIiJ7pzSW1g=
Received: from DSSP221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::15) by
 CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Mon, 26 Oct 2026 03:21:30 +0000
Received: from DS4PEPF000001BF.namprd21.prod.outlook.com
 (2603:10b6:8:3d5:cafe::5d) by DSSP221CA0003.outlook.office365.com
 (2603:10b6:8:3d5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:21:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001BF.mail.protection.outlook.com (10.167.23.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 03:21:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:21:29 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:21:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <igocaike@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH v2 7/7] drm/amdgpu/gfx12: flush the scratch register write in
 the ring test
Date: Mon, 26 Oct 2026 11:20:23 +0800
Message-ID: <20261026032042.2266892-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
References: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BF:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 62560013-580a-417a-00ac-08df33103a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261021121427099003|261022105027099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: ASZAbfzQXaZQpeYyAgACBX+GW+CgZb96dk11d6dMtgewIR4DBSkdTCAqIusH2/d6fbBL7FuGvf2z3bsQjKQSWkxQjwdVzr4W3JoZGdAaTFW7jVlfrdHnLrV7+8dcl1v94L+oBUUcOVdYignGo8JCn/K8KoGfhU7M3LEXHnN29l/N3nSOLtCxMzmIJ2uySQo6DzT5Wvs0s3sjN1/FMXIqTaWyVHcvCwZpixa56leRHv9sK/TB0gphEUS5QNAYXRGUjKIQ0g+uXWcar/KDPmfl+RYgxpusq6lXcD4Fl2O30N8syO9yHLc6ZIAIGaePWQLril6GmQ5J871PiHRqUu59geMnayAe8oSaBFl7xGiwCA9o9+gfkDrCMaEF48ay8joTrYU39n8Coivfr4mQWpT5+S5udybREIBK0tLF5wsf5XYfagIhBNri1BUzazThRsCa4QeoQibV7gTh/fQiqQV0HOB+BbYRIeogzaxbBfdbs5lto7Q6ZqXINHBA65rsi729L/krY1k7wUdtxLUqMZWsa+YbQltaHIV89SXYW3KYXDQhkP4qVcyAtEjunlvn/MPSbdjaim6c5d6dmJ6UllJDWOJKrRwP4xwgEvTzh7NxWsZFx97EvDuFQEW/11jnktJ+CuoQG8B8fCpW1Z3gAC1AS+fqrDOMVF4414rWVDyNw0l7OoheUp9heT2VPuhDdPyw3PR2eyv3w5zcyYnh4YYEUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0fFEptwwrLjx86ANDf5cvqr8D3K1ao9KabhHtmq7DwnYPCr/Adc7T+Uz+f6TRETWpToEl0I78mSSIuHVqCD0HaAtQCpSn2+d4nV4tobVn0kMWWh17s+gkuDBl/1e8mAZhGDY+8BfbqO2Gi9HWMY7tTEwSoaOz2M1fDouMEyQQ1pJLhxsKkvCmE5iE3PT3e0BnovR+ufJyzDqvjzWiOPITsnk3EhMQLqIYJ0r5tz0dMCGU65lHFeZ37BKi9/Lt0iF4OK0CVf17bKlAqTSvBHy7ayvc6PozQGs55Jjd/h7iHFGIuo2lmv1oyrDFX1zc6gEmbDszzF62TFFLTH8DcqmxvGfOr8QV6QGeZ1xdMY6ArTez6JZM/L9RJyDpnWydC1E7W6Odtr6YYj+dxDZugSLc6jpc9ROzSOcCZRFfFO7CEiloJAILQqalhAU7v65djEM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:21:30.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62560013-580a-417a-00ac-08df33103a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, rings the
doorbell for the CP to write 0xDEADBEEF with SET_UCONFIG_REG, and polls
for the new value.

Nothing orders the posted MMIO write against the CP's write: the
doorbell reaches the CP on another path. With coarse grain clock gating,
a GC register access from the host takes about 2 us, and an awake CP can
execute the packet before the 0xCAFEDEAD write lands. The test then
reads 0xCAFEDEAD forever and fails, although the ring consumed the
packet (rptr == wptr).

On Navi48, 39 of 10000 back-to-back compute ring tests failed this way.
None failed when a GC register was read back after the write, or with
CGCG disabled.

Ring tests run on every queue, pipe and IP reset, and a false failure
there escalates the recovery to a full GPU reset.

Read the scratch register back before ringing the doorbell, as
commit 3f69d5860f5b ("drm/amdgpu: Add a read to GFX v9.4.3 ring test")
does for a similar race on gfx 9.4.3 with multiple XCCs.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..23c771dcd535 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -458,6 +458,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(scratch, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(scratch);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		drm_err(adev_to_drm(adev),
-- 
2.50.1

