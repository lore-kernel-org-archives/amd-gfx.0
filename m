Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAEAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE7611291E;
	Tue, 11 Jan 2022 07:10:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBF311291E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfqwJfoQQZjwUyhLwlIfH++fOZj/BXkQfM5YKoaYCMsKam3koJqwYP7NlVuq2smauvpdZoQnWJas0D99oFfFakbIMhA+GeYnAVHHdcTTGkKzV/OhMRlnd2/+/14Y3ORCpEK0J4JupEGyhsowevCuGinRdl1YBQZOGQTh9hMkxN/NCS1GOaLL5vlWBF0fmFBRpIbOt52NEiGbqZvKVF4DAa+rmgITc0dJl6iprYBJBripDWWw9miXSp66iPV6VUofJNCv/DJruKDcHBXJ9UJrR75oSOnr5i7vq3mSGXyV6kro62zR7HGM2fGUXIVLnx3JNeGWNiXEG457eBV+08cSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5rWMsDMTO0Ky/lhP/3PIGYEL1o794y/SQU8BghUELg=;
 b=ZXhyV3Dl0ME9tpP8RE/YGtGlXOu5j9pk38CpOkH3EGbKGNKMDOEuVRCbJ0Of//+2zUtIXuH88+Bs2XinUEInSzH/yGLGpa2K/TNnvYfQWORZ9wjMuiQfkbTGbFYn0aI4OiDLYRsbQcbKi7lhpvzPiGgre9hzJP3DEx0ilRWhUz34l76qOboHOdlXukjBKJMJysGdZyt8sjfJMomt4aq+LEwnv42W4npeQhOKs5Yxm/ngKj4q2raUWRno8HE7nTBypTEoE/Jmp4MLRuLtUnKucD0uCs6fuqmNBCwgM0lKbh1cH0BdsuPN9IZESd+NN9WQVms7HztnqfSZ9P+ChewKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5rWMsDMTO0Ky/lhP/3PIGYEL1o794y/SQU8BghUELg=;
 b=CVX5X9G4IaPeOJV37TVRRVYChRfnc51pK7UQqw2YMshAG/6cxgTisYvJgxpgPphJQqY58On/ZG5FJ4rlQtudax93y2VU5e+JaFyrEme9/Db+EP4LeaM6h1ckzkTpsnKXybo/oR/Wf3Kd2vuTHxYbca0XKXa/IWlI9E7D4035JI8=
Received: from CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31)
 by MWHPR1201MB0223.namprd12.prod.outlook.com (2603:10b6:301:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:10:03 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::ea) by CO2PR04CA0129.outlook.office365.com
 (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 07:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 07:10:02 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 01:10:00 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: limit the number of dst address in trace
Date: Tue, 11 Jan 2022 12:39:43 +0530
Message-ID: <20220111070943.5370-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d75a285-f350-45b2-b50e-08d9d4d16374
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0223:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB022344DDB7D94D663D7293BCF8519@MWHPR1201MB0223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Qn2h5NuRaEb2lP9B1Foif6EowQHqiLa05r0WeA6UFadGEL7UkgbZ5DAK3mXJk20/eFjOqHUBhCGHnZZyfjxyi97ueVmO+sJlvXgDOtk41O8YazaZSUcR3C1aYvIdh+oksuFsbYEBt5SInJ0xeIuCdk5Nuo4PJfnqdgI/+QvfA7ukGBmbI++ETt1XaFqM5nYMlnYthk0X4iqG2fIjHvEwzOsIty0gV5i4dO1LTcayCEc+GmMfeLq2L/M/1EX9O1HRa22QzlyZ0ZuY3gTJxnPBOHh64iXUEk6YQodNPtU9JbJNI6OjCkid86vh6WxzqfeKRKhPZHmRRc/Ktj5LkxHevJ6eq89hrhMl9srE/6ZVNJp30HrVo1hFUYYgDEzmL2cdonqQccErP+mtQDiS6U5a8LPmly+bMTZruud56PCZ2BiJ02CwnuSfafT/nwLa3k14zGDmDSASgjHFKbqgIdWofxefEy1ZmxQAf5NCmiD2+YXyq66EtUfEq1yoXfTDXiqNANJ7L2cDoSlrPkpyo9I7z9H6wnvN9UzvTroeVQjvHNp1Sh/3Yq1tEfKSUHYsxfd32wlvLdN2B0YMkxNiNiVE70F3WXRCJ2c6cppgcvHKdFTl1t0T3r82/9M2n03uuzxsAHIDNCPJTkSq0FwjfIA3d0/umK4LWK1kFaxwKwDa2nVm9/hlicyOpx/cDppUkODQ6bDjGYv+q3ScCLPoqmZJHpMQ1WpgS9fr3T4+/0DfxliGEYRXvhNdagW46KokybkXj0Z2Ad4AlrYYQr+c8W8NoPXaEzH4czO1i12mjlf+kg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(2906002)(16526019)(186003)(86362001)(83380400001)(70586007)(36860700001)(36756003)(426003)(508600001)(1076003)(5660300002)(54906003)(70206006)(26005)(4744005)(316002)(7696005)(6666004)(82310400004)(40460700001)(4326008)(6916009)(336012)(356005)(47076005)(2616005)(8936002)(81166007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:10:02.9763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d75a285-f350-45b2-b50e-08d9d4d16374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0223
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
Cc: alexander.deucher@amd.com, Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

trace_amdgpu_vm_update_ptes trace unable to log when nptes too large

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e7dc23f78e7..0630bd43238c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1632,6 +1632,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			 * silent to stop fault floods.
 			 */
 			nptes = max(nptes, 1u);
+			nptes = nptes > 32 ? 32 : nptes;
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    nptes, dst, incr, upd_flags,
-- 
2.25.1

