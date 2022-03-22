Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8239CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 17:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD3410E00C;
	Tue, 22 Mar 2022 17:28:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB5110E00C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 17:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcAZO+q21qYvRtfFgyYFr9eHl/qroIDlvgYV81BWpKV2gPZ7Rc5d7CQnfdxWz8S8aUuv0a5jm2ThS3pWveM7zegHSCv467PFxgWJqraw66Y53K3ltJb1FTHzF6OxoZW6EQsblGgV8jUi4jgBRm6vagWUdfTXM+6obNKc2K0tP7lWR2iXoEBVBitpMSsuoe7KwL9Q0gRHCL+/saBa01w/FplJj91un3geTDz5dtbtv9KxrgA5aYAvlaHxsDA8lc5B6kGg3QZIJ3TYmBW5bbbtnqZLKKaCF4Q+PIgOcyrwi45JR4MdhC7zEKNNC7ftg22ujIXb57Lut4PAQONmhwjDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9mAzZU6wpGdVQBjtGoSRDFJ6661rIq2M4IXMG5k+WI=;
 b=NiEk3bShnHVvVb9uNj5fC4qU7HbYpueztLVM63VlM9M4L0ELSp1pGeYqpVbbS2emH9qknaXGtWPXDz19+YZUVQxhkava1fhME5qpfxe1T2JDpxyPx9GPov07qDAC2UMQdEQqwA8Jgcl/DT2U9FWJidwGeLwEE6wAveiy4zkvhD8IsZOGHyTW4/6sH1ab2IzrWuV5BcO7nVRDUUeTfIr2VJyVC+Ws0FxqizGv1ioXyefBtPOPzyOOiwvp3gJEHQO8/BKVzxFxcBDTVeHFnEPqLhb+DajKq6ngjXQriBtobW9FNdxef6zDdAyGbLKKKmi8Omgk4D7sXIZHJDY9rhDZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9mAzZU6wpGdVQBjtGoSRDFJ6661rIq2M4IXMG5k+WI=;
 b=2t7QYjyHr9wAeoyd8BTqNLPPs8ZWIPG1BXSWmtk8hGbiNv5Cx6AMwdIYr1JvaEDljfzLRJYR9RTz5Jarray5pxFgxeOvO/53ZNUD8plF7zknR9s0E/0WZFhpGheqvFxRNqtt7VmaWeWzT9QTQuKihTR047+gOV+kI+4w4s9Ycyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16)
 by CH2PR12MB3880.namprd12.prod.outlook.com (2603:10b6:610:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 17:28:47 +0000
Received: from MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7]) by MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:28:46 +0000
Message-ID: <5741ccfa-856a-b0a8-1a70-4b7b5098144a@amd.com>
Date: Tue, 22 Mar 2022 10:28:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Daniel Phillips <daniel.phillips@amd.com>
Subject: [RFC] Add KFD available memory ioctl thunk support
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dabadee-0322-4d07-9110-08da0c296b5f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3880:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3880B87092CA46C5B71BDD5DE3179@CH2PR12MB3880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng/4+hFI08IB2de0CFH8ygak81WnxP0eWhVHyGCCimJnHKtAPPwtYhNqJbfsnE94xPoFmzBO7tQhwh6CN9D9ctIz5plivWQylWtUPQ036dGEbldqy3lyYyQ9GkHvUQGnAuwUf5J4aMRH/UevHwoIRzCark7TrEKNsXA/9NNZLDiL1G4aFMmCTG8HPlVPefjOOi/QIKYIjOD2z9Ty8oAPDIlTYzVkF+ETKhHV4xgkTz6ySMDJETAmA6+8d5zogQb51ptQQMed5dnHTXlStt2pDr0c6RvNRz+eHqZJpOqLaQpIAe3Wjy07o+RKCNoxpGWh6muQ81Kk5WQ9djF3V6GhY13BSC1cztMY5fR4fylEjgNRvYQnW3RtvSpEVUOSG1v6twsHCGmSBAGFU1Nml+NsQjjHBoPDCa8gNLrWJu3ezlDeZByYO19N8ov52Fc8khWRqi+jmJjsuHuqknwBEfpEuY70ri1H3Y/KDezfEj/dNpZyGLJED0Gg70JmNiMSMIGiFF414/yQf0TjUtCmmyjSMOQxvyUYgykMDnxyYmj4AYNAhU1wjhjim1e00K+aW7qiKeG0/wQt0EMC9V/Jk+eUPFFxPIu7J0wCJsvOQFPijQep3f0UDcw7uozHwZlFNm75WTMsFUxuGe7FKDwwkqDFKaLr4JKxUo1om23RqJNroUhfO/0967X0xv1yCrOfVY7uqZggOMuqEqOP4eUB1E098C8V7GCOUPj+OMlYH6SzQeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(6486002)(6512007)(2616005)(8676002)(66946007)(4326008)(66476007)(66556008)(31686004)(26005)(31696002)(6916009)(44832011)(186003)(86362001)(38100700002)(8936002)(36756003)(6506007)(316002)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElrNXZ3TGhrUjF2UWxVNEdrZmVJUUc2UFpvVTE1bzJmaGNrTUpjMkpnbTMy?=
 =?utf-8?B?VDBINUExTXVyd0lxY3hwL1FsVDFNenNWeTRrcFNkakZuRWxNamFTc3lHYnZx?=
 =?utf-8?B?eVVSRWdCUHArRXgrTWYxTEdBQXM5TzJVeE0xYmRVSGVQeEduRHJUL2xpR3ll?=
 =?utf-8?B?aXRyNVFSUlRuZEhxY1pWcVVWWTY3VEpESk5hUkN1SnRFRGduOEZNMEJyTmU0?=
 =?utf-8?B?Tnc2REdiWHJ4SEJFWUV3NXlLbnBFZVBOT2E0QndmZ0FyZnJDMjkrQ25nMjkz?=
 =?utf-8?B?TnhtV1NPdGZ4alU4UnQ5K3J0RWFXUmNuV0ZMUmsxa0txa2g2MlZBbDY4VzBq?=
 =?utf-8?B?Wks0NXN1eklBb2srOXlKdlgxUDdpRXhrN1pHTHdBYnFuOFJBNndXZ3YrQmxv?=
 =?utf-8?B?cUkzc3ZQMEo4bmdBU2JLWm1xeHhObVdvTHMzTERTYXpUdWN2b1BQWndpVEVQ?=
 =?utf-8?B?a2tYN3lvK3BUQ0lDM0RXNE9TZXVLZFZ1UWlmLzM1Q0R6QUl3amU0N0RvOWd3?=
 =?utf-8?B?N3NWWVBSRWt1ZXZYSUFESE03alZEbnYzOU9uaHBVbTZETmdKZHpyT1pUV1Y3?=
 =?utf-8?B?N3A0SVQ3MUFZek5qWENOa2JDVm9lWm5kNXNPelZOQ1lwQUlhcWlrUFpqeDlV?=
 =?utf-8?B?MjJLWi9VSndKVGFqVWh5ekprS2cyUWdwNVBqbHpDZUVlNTR4aWNERXdueE12?=
 =?utf-8?B?NDFESm0zVjhCbXlwWDcrb1l6TGxpa3JBNHRvSC83TVpkNEp5aVN0WG1KdG05?=
 =?utf-8?B?MlNiSUovUXozVVliZ1krU2JlQUF3all0Znc1QWZ5YnhwQ2kwdjJtdmpreGhH?=
 =?utf-8?B?RlVocStmVnZmTTl4MVdCazJhb2pnVWtHUCtZM21YSU5jSnVxQTNMd0JhaTBB?=
 =?utf-8?B?NzdPRXlXN0FEbFFuRU9HZ09Obml2Y2R3d1JwbzFQcHgyVm5ld0Zkd1ZHcG93?=
 =?utf-8?B?ME5rd0wvZU11eVpLZWNIbVZwcEI4UE9iLzIrQ2lUR0VMck9GOUxha2Vac1ZW?=
 =?utf-8?B?UjcwVlVweUpncUxGVkJxdFZCTTE4STlxc1pPaFF3dDdYUkREZXIzYUxBYjl6?=
 =?utf-8?B?dWJPYWxpN2RlR0xPeXd3eVgybjJ3T3hqU054Y1lBMHlkVG8yVjQycExFM1NW?=
 =?utf-8?B?ZnpzbndVMDkyQ2JtbWdyQk9yc0p0WnMvRUNuK1B6NmFZZFFTOFhLb0Z3S0tH?=
 =?utf-8?B?UFBML1l5Z1hZdmxSOUhoQVhIVTM4N3ZOeEtYZUFESTJmbmtSbmtzeHlTU3M3?=
 =?utf-8?B?N3NpYTZmbmFmSzEvMUp2VHpxNkRIZWF2N00zZFBadXNXbWtCZkFVcVY4Z3ha?=
 =?utf-8?B?aDQ3S01zQm5mcW1qSkhqbEl6cW1ZeUM3U3pMOUpPcUZST3VmcWFicmlTcndL?=
 =?utf-8?B?Z3U0MERmSVBkNmVCTkRjVVk0bmJld0FKMGhxenBlZXZhTTZHQjNkMXM1cFVF?=
 =?utf-8?B?RU5iQlQ2dGJCeTBPRlRlV0hwNWJiNXNSMXY2RlA1Z1o0NjV3TWtURmtPVlVZ?=
 =?utf-8?B?WUdlRHNBWlNGeUhKZXJLYXVBbzVrTklOS2g4Z0lDNWF1WisweGhQaHdhU0s0?=
 =?utf-8?B?aWo0T2hSbTM2YnA2Y1FLWDJNeWtHbzNjUENHUXAzTS82NVAwZkJMZStPdEhr?=
 =?utf-8?B?QTZXalZjS25tbGk0U2c1QjVYNmtjYlljb3I1eFAyb2xzaFBrZi9GTlFMMStS?=
 =?utf-8?B?QnU3MFVpZTByQkJ2a3BFeXc5a0ZTU3l3REFMcVJnbnJtOWx0dmV6SVkyMmNN?=
 =?utf-8?B?YWVsSWJRbWw5Tm9QdWlReVYweEhlRGY5K1pTejB4QVZGWXl2bEx0MGxSN3ZV?=
 =?utf-8?B?Wmd4YnJvZXo2S2I5cHp3eEc0VW1UUFhvUmFtdHFkTWlyaEk2RGZ2T2lobjlQ?=
 =?utf-8?B?WTlqSW5vaENCY2hmbnoyWHlhZFlzN2FDMHhJWC8rYXVTOXdWa28zMXVicloz?=
 =?utf-8?Q?1I0psSgZuct73jrKk689oU21jYKLHoJx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dabadee-0322-4d07-9110-08da0c296b5f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 17:28:46.2682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYQz0eKwruZgy0tUrByvoOJ2C6yJxH5ipo4SsJnucrmOcL8lGJIM1O9ZETiFKoPBo9Ot6U/i+Bd6slyMLw6yUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3880
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

This patch adds thunk support for the new KFD memory availability ioctl.

I am posting this patch inline with Thunderbird just for now, to establish
the principle that I can post patches/code old school style without
mangling whitespace. Please bear with me while I get that sorted out. I
will switch to posting with git am  pretty soon.

 include/hsakmt.h          |   11 +++++++++++
 include/linux/kfd_ioctl.h |   18 ++++++++++++++++--
 src/memory.c              |   23 +++++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

Regards,
Daniel

diff --git a/include/hsakmt.h b/include/hsakmt.h
index ff2d023..abc617f 100644
--- a/include/hsakmt.h
+++ b/include/hsakmt.h
@@ -374,6 +374,17 @@ hsaKmtFreeMemory(
     HSAuint64   SizeInBytes         //IN
     );
 
+/**
+  Inquires memory available for allocation as a memory buffer
+*/
+
+HSAKMT_STATUS
+HSAKMTAPI
+hsaKmtAvailableMemory(
+    HSAuint32 Node,
+    HSAuint64 *AvailableBytes
+    );
+
 /**
   Registers with KFD a memory buffer that may be accessed by the GPU
 */
diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
index 8a0ed49..abfa948 100644
--- a/include/linux/kfd_ioctl.h
+++ b/include/linux/kfd_ioctl.h
@@ -34,9 +34,10 @@
  * - 1.6 - Query clear flags in SVM get_attr API
  * - 1.7 - Checkpoint Restore (CRIU) API
  * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
+ * - 1.9 - Add available_memory ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 8
+#define KFD_IOCTL_MINOR_VERSION 9
 
 /*
  * Debug revision change log
@@ -769,6 +770,16 @@ struct kfd_ioctl_free_memory_of_gpu_args {
 	__u64 handle;		/* to KFD */
 };
 
+/* Inquire available memory with kfd_ioctl_get_available_memory
+ *
+ * @available: memory available for alloc
+ */
+struct kfd_ioctl_get_available_memory_args {
+	__u64 available;	/* from KFD */
+	__u32 gpu_id;		/* to KFD */
+	__u32 pad;
+};
+
 /* Map memory to one or more GPUs
  *
  * @handle:                memory handle returned by alloc
@@ -1328,7 +1339,7 @@ struct kfd_ioctl_set_xnack_mode_args {
 		AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_args)
 
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x23
+#define AMDKFD_COMMAND_END		0x24
 
 /* non-upstream ioctls */
 #define AMDKFD_IOC_IPC_IMPORT_HANDLE                                    \
diff --git a/src/memory.c b/src/memory.c
index 6d2a4f4..b2cd759 100644
--- a/src/memory.c
+++ b/src/memory.c
@@ -199,6 +199,29 @@ HSAKMT_STATUS HSAKMTAPI hsaKmtFreeMemory(void *MemoryAddress,
 	return fmm_release(MemoryAddress);
 }
 
+HSAKMT_STATUS HSAKMTAPI hsaKmtAvailableMemory(HSAuint32 Node, HSAuint64 *AvailableBytes)
+{
+	struct kfd_ioctl_get_available_memory_args args = {};
+	HSAKMT_STATUS result;
+
+	CHECK_KFD_OPEN();
+	CHECK_KFD_MINOR_VERSION(7);
+
+	pr_debug("[%s] node %d\n", __func__, Node);
+
+	result = validate_nodeid(Node, &args.gpu_id);
+	if (result != HSAKMT_STATUS_SUCCESS) {
+		pr_err("[%s] invalid node ID: %d\n", __func__, Node);
+		return result;
+	}
+
+	if (kmtIoctl(kfd_fd, AMDKFD_IOC_AVAILABLE_MEMORY, &args))
+		return HSAKMT_STATUS_ERROR;
+
+	*AvailableBytes = args.available;
+	return HSAKMT_STATUS_SUCCESS;
+}
+
 HSAKMT_STATUS HSAKMTAPI hsaKmtRegisterMemory(void *MemoryAddress,
 					     HSAuint64 MemorySizeInBytes)
 {
