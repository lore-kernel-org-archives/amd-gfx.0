Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F60C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 18:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE9C8925D;
	Wed, 23 Mar 2022 18:39:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6568925D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 18:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBeTQMUK5WjmPPt/R8vbaypii40iSaMbQvTz7Xz625oilCo25+Y4fpgb8uU3pObVl+O/OsF1199uqroxh2DcbItIbd2h3eRhCIe170jKWM9zljxWiU0HupnPBwmMK6uWLv3RphInv2kRmXnat71GO0xrrlJ3wtYbkX0zy50D1tH3IabESqFPyyJnGd8SE1zGuHfPAu5v2S29l2/FyKllTWTcDJkffH2jjVCzcA3ExrOGU/Tk6DYxgL2nVxI3aXf0VfvyAlKWr0tSpIA6FaYzWsE/vRzc2eKFkO/w8WQ6VtFijpggnF0NPHvum9ep7A2VD/NF9sLMx3s4JoS88VVD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr35s1Yq89knmBPnw/a8EU8AkDTzj4XdWSNVOe7y/Rg=;
 b=F7bYrD9KuF5O+J4HLlilRq7jOhXMLaTs5mv/Q7nBWt+0NTmZCI4vvBGhZB86CT+XCBCfMapPTt6FgwiYpQQ6AvjNoF0bwJ5H+5e3C0i/FBW5DAfKpMLP6dcRFNR2lsTiTh4LS9KUiitrgw/IA0s+y/6gEC9efse5fDuiCoYJoJ9+wn0jyH8JP68Pz4vpUZZezYmbQDJ7PQHBy3Mtee4+3K6gFGgpDc8CTDMlUAWmX/9eke6WfQmjvc6GpNbFtzUS2c560r+uybFoDMXDFDRCb8bR9dWbxXM2WM94yVci2qCLeQsdEJyhbPbpEWAnHkdhT+u5Dvf4JJXc4/q9dEv3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr35s1Yq89knmBPnw/a8EU8AkDTzj4XdWSNVOe7y/Rg=;
 b=MFIkQGAGiFSmMBosPSC2v9ylQlU63psEuCCEwfsD/z6uHSHaMnE1DI2kBFzSD3J3idqSW7r+TfrGwOyJSsmh2WG3LtrAwR6ab46kn4dOGqnWk8tXc0VFZF5UPOX7QMovZp97lhQWWVnkFHAqCDob4RoZEP9p1sfqIQhlA/H9jh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16)
 by MN2PR12MB3214.namprd12.prod.outlook.com (2603:10b6:208:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 18:39:29 +0000
Received: from MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7]) by MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7%6]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 18:39:29 +0000
Message-ID: <6efe2292-5991-c051-1f3a-e5615c101061@amd.com>
Date: Wed, 23 Mar 2022 11:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC] Add KFD available memory ioctl thunk support (rev 1)
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5741ccfa-856a-b0a8-1a70-4b7b5098144a@amd.com>
 <DM6PR12MB5021C430FE412C50B32DF18495179@DM6PR12MB5021.namprd12.prod.outlook.com>
From: Daniel Phillips <daniel.phillips@amd.com>
In-Reply-To: <DM6PR12MB5021C430FE412C50B32DF18495179@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::29) To MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76016f9-0c4d-4b4d-cb95-08da0cfc76ab
X-MS-TrafficTypeDiagnostic: MN2PR12MB3214:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32142EFC6FD860B3653DE676E3189@MN2PR12MB3214.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkqmuMvATNsjoIyzTFVpVbUslyVnF3zM4tb03HEVXzOmpE4Z4DgWt9+iH/42JU0Wsd8+yVd0ohcXWbNGfz1N65Uz327pGqpKvjltO9Tjs8TDWHqUI5MHjrGYh6QWj/1A3V+u/MFhSyj7Io5kds28UR5ngMO08LE0NCxYXh/v49t46wGiyPfYCIr4lzKVGaIcf9k5NJF/3LAnQkwa2lrbJRAfEYhi1AbY4Rd4OcQLEnV4s1aHdnEb8C9RD6BvANU9cetTqYTnm7nJSD1x839qE14uW+AhP6oDQZKP8qcRZ/UnZ4FFlMUxUNsqrGtv6MFpwUet8MX2/+xknns4stnJpP+edLiEyk/8BttvaCIQBFsp+YMAfENnz3nNoXUOnhznvSD5HiYA9penHKr0E7erLb3ilE0ksMZ9WGossRte1zG3GYfhdvhEZWpBC3T2v48nri2+9gT0MW5NfzDGQ6LTkEIlg60hgeR6pZLZ0dkIHNeFXZ/O5UlGoC0AVS5Lz+DrfBvOtezJL+5Yr7tsgAQCkw4SIBCS5wHlLe12CxUGrzlzeiGVP5pfN5O154vZXEXA35RVYfKrzr0g26/ePNnwZx0QLJXj52SaiGdP4MO1i59HUmy/1jbnWPMhh8824ZexBqbABp2viHRYYiwkqrhBIJ1OU2kXQrQiniRpVeGOjrnXDAh/w1Ttoa9Bbprc1MMUKs3eKU1H1rCyA3jCFCyRn+DXzlHPN6soLuvBrthpYJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(66476007)(66946007)(8676002)(4326008)(31686004)(86362001)(36756003)(31696002)(53546011)(6506007)(44832011)(5660300002)(8936002)(83380400001)(508600001)(6512007)(26005)(186003)(6486002)(110136005)(66556008)(316002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5qS05QSTgwaVd2c0p1dXJFQlVBR0p5dndNOTlPd0IvUUd0ZWdDQUNzVmZy?=
 =?utf-8?B?SktqYmtFMlZMZytpUmsxZ3FmRjE5TDVUaTVnM084ekppS01xL3dPMllCNWZj?=
 =?utf-8?B?bk5jQWdRSmJFeURxTUV0YVdzaWpIZjJpZytud0tadjJ3VU9DS01ZYjNtZHVQ?=
 =?utf-8?B?TnRHTDViamRpUzdrWVArMW1EMXhhSlVIYmlzUFVzK1ZSbldoSkhCL1ZDbXdG?=
 =?utf-8?B?dEdtMjhDMmRBTlpJQ0ZyWnI3RVJORFAwOFJSekQvWWFNd3lVWjhWUlRQRFpE?=
 =?utf-8?B?MmY1RFk5V1p3Q3JCTWtYS1pIbzlkRnNldTVHdTJ3S3gxdmUrNnFZdnUwOEls?=
 =?utf-8?B?R2oxd2lBS0N5bmtlbVJremhienFFaHAvMlBHTnl6WlVVa3ZJT0lQOEtNcmo0?=
 =?utf-8?B?TXJoOW1ZZlplUjNaTEVnRlZxZXlzclJ0cERXdEcvVnVZOXdHTjV2TWlYT0lM?=
 =?utf-8?B?TU9USUg2cmxQR29BbUE1SGFUc0JlZG9rcnJrWlFIRloxQ3RqOXdNWkpBWTZh?=
 =?utf-8?B?QjJvR2grci9YSlRiR0YzRFBodzU4elFIT2l4N3RKUmN5NmZhaDZCUVhCbnQy?=
 =?utf-8?B?QlZOMlptbVZpY0RzUFE2T05LUm9QdEV3UEJHejBiVUJxS2sxVkVHUWxXMlU4?=
 =?utf-8?B?Vk5zVWJhZmluUnlRYnE4Z3hXOWI1Vnk5ODYyQlY5VkpWQTd3QWUyaEJDelZk?=
 =?utf-8?B?NmNFb2JzYmQxSk1pUEJLTDdzKytwcDFxeE5LYk81R0h6WWFOZkpvYnM3MWxn?=
 =?utf-8?B?citRMG15T2NqWjF2UWV5YW1SclhOYXpLYkdIa1cvKzhWQStoWHBEdGZWbGRC?=
 =?utf-8?B?Q0RtVUY5V0pQZTlwMGFBZURPeE1CTUR0QTJlTXA3NTUraUkvbk9XZ2t5ZjZT?=
 =?utf-8?B?RmpNUG9KNUpObVAvc0RtL1BZdFZkYWdvUEx4ZjFLL1NkMkhOTFpCN2wwNFRN?=
 =?utf-8?B?ODcxdDh0UFJpZkJSTDdGSVpSaTdaUmd1NUk3VGR0eER0U01VSXdqUWdIMWR4?=
 =?utf-8?B?cVpEVG02VFRXbmpDYnZLWDdDbisxcEd3S3VnT2Ezd0MxVk9YUjdlRDlwN2FL?=
 =?utf-8?B?NWlxLzFUYUwzZndsTHQrMzMvVWJKU1Y0YTJ1R2JTbmZWakR0K0pwcDV3RWVj?=
 =?utf-8?B?M3puQzlTYzlYQXd0U2R0NE40bmFaVlAzaEN4RFZYalo5WkRiR0ZCQ09scEtV?=
 =?utf-8?B?SmdFUVlXbDk1YnI1SEk2T0NFVS9TOXo0ZjcyWGFpQ2lFRnN4WVVLYkF2aS91?=
 =?utf-8?B?VjJDYmhvbGV4dVl1S1ZPUlJJWWlyc2I5Vk1PZmFBb3BYR1lmL2hLWTl2eXlD?=
 =?utf-8?B?TGpoV1RzWXVyc1B5UzBkYWRJS0pMSHZnN3RESGMwZHRUUkFlZ1NFckFMU3Vu?=
 =?utf-8?B?eVFmaEl2LzBKU05vbDIxN0E0YTRGRXJtckNzcnJpUXBNMFBENzBRajNpQ0Yy?=
 =?utf-8?B?Q1Uwb3JMT0xCVjYrR0RXTXJSaVJCeTV3QTQrTTY1SGFCMXIxWGZqYWQxZXpC?=
 =?utf-8?B?WjRBMHVpZytZSkdRTm43eU5yVmdqUnJLU3FtZGR1Mmo4c1JOZmNnSU5zK2t5?=
 =?utf-8?B?TGhDN2J6ZmhUaGxha0wwbUdGUGsrbHhOWlowWTZGVk03RkZ4UFp0UXAwMVpV?=
 =?utf-8?B?TDBMYk42ZGRBT2FZd0RiWFZBWWxWUDdmSjJnVDRXS2wydmtJOStIczhId0NX?=
 =?utf-8?B?R2ZBeUV0SllZdzV4cmVZcTdWZ1FXeGl2bWxrdUs2Mlc4Rmg3OCtnUmUzcWtw?=
 =?utf-8?B?eXpGYWdtaDFaNm9qZWxrQnZseWRGTmhUK3dkanFidThUMlFoWDQxNEdWU3lQ?=
 =?utf-8?B?R2lVR0NrdERBbEt4Qnh1aGVRVnNYbU9QY1c3R0RqWEd3aFNkKzBvdll1TzJ2?=
 =?utf-8?B?ektKdGRqUzFuQWp1OHNPWmd3VThTbGxwZnhvbnNxM0VESFA3M0F4Y1g0QnRt?=
 =?utf-8?Q?IvBHOVPENJ8w5LhYZvopMWRksXpInoDB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76016f9-0c4d-4b4d-cb95-08da0cfc76ab
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:39:29.0639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDCWyo8U6R4viJdwSNHxijx6QQelgEx7RaZRC5OsO7jKLqUNM3EcPfYHSdoixnBKXFH5uoxqw9sV660rJSvLmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3214
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-22 11:20, Yat Sin, David wrote:
> I think this should check for minor version 9 to match #define KFD_IOCTL_MINOR_VERSION 9 in kfd_ioctl.h

Fixed.

include/hsakmt.h          |   11 +++++++++++
include/linux/kfd_ioctl.h |   18 ++++++++++++++++--
src/memory.c              |   23 +++++++++++++++++++++++
3 files changed, 50 insertions(+), 2 deletions(-)

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
index 8a0ed49..96f432c 100644
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
@@ -1327,8 +1338,11 @@ struct kfd_ioctl_set_xnack_mode_args {
 #define AMDKFD_IOC_CRIU_OP			\
 		AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_args)
 
+#define AMDKFD_IOC_AVAILABLE_MEMORY            \
+		AMDKFD_IOR(0x23, struct kfd_ioctl_get_available_memory_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x23
+#define AMDKFD_COMMAND_END		0x24
 
 /* non-upstream ioctls */
 #define AMDKFD_IOC_IPC_IMPORT_HANDLE                                    \
diff --git a/src/memory.c b/src/memory.c
index 6d2a4f4..8f99589 100644
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
+	CHECK_KFD_MINOR_VERSION(9);
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
