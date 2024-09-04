Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DDFCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 13:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8B710E0B8;
	Wed,  4 Sep 2024 13:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uL5lmAF+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217DD10E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 13:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9j3qEznjwpbXlMEoXDuaYbpJJ3atQh8N2spvaTnUxry5dmToka8M9MAAwUdhrwvzLU8cA54aGWznBBY2NId3CHxLjg8sV41dim3LbV4g1P6uB2YUgdzm8PGBJtyg9JYJcJN0yoU61E7hzx+AGMKkdi9zp/vp+nZQ9Z2+oBFhIvIVKCPpIo5PaZvWlqVQy0IRBJLqAJilBFF56IUWMRBsX38er6INRVvMaqnj9g9wnj9TjgRXevF1pR/T5R47Sgt6e8V/9LkOJQXoOUbSr1mq5NO5wGMJUbt3aT6V0qxcEIV5OAKyUJTw5e8mUC1l4fRL2bJGDl2z6pPfIyrssLzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MohBHRWecXSRQadM23YvDvZUiB3pYsy5V4OhV8bb03Y=;
 b=UaRsV8C61JKrH4GfdliJqGn1vnirl/Ixthl+wtQkismSzEFATqHhPB61T1w/jx0YutlaQ4st0J/lBeCwsutNC4sefo+2jWjd0tfy06vG/E2f+J2DgZhzfFYgEFx2crW2UMhI2lP1JeU96RC37sMpWn6MQX7iU1DZUpGqwIMbKpRpMsfVi6wCiWjj8nEJbbGR36blpDgGkfsF0CUgThJTUnVZqz5jK5gcA0inFLj3kA1WzG+M3WbyhR43enF4hMDOmUBh7F9LC5u9df/cztHvaELD1ZaO6ytsMnL38JP0BZKSo4a0B5VQ8Kw0W6N7XIyYZwTwOk+i/c5Nvs8npSi9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MohBHRWecXSRQadM23YvDvZUiB3pYsy5V4OhV8bb03Y=;
 b=uL5lmAF++ZVN/7MELSbrX+ogLZMmzFBZHtD3kD65OWTD6XZDc/LkVofSF1/ANpvGcuc8HsvYmC7pgirz4pB7SMM/WbKymExdaUgMM7aloFZpVJvLBBu72gqKmy0S7ikYwGFSkKZntymqK/Z2UAkrJNdKy0pmYRgGQqNMTmqSCJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 13:15:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:15:01 +0000
Message-ID: <202154a6-95fb-13b0-b863-c34caac6ae49@amd.com>
Date: Wed, 4 Sep 2024 09:14:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: fix invalid fence handling in
 amdgpu_vm_tlb_flush
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240902030305.11952-1-lang.yu@amd.com>
 <c94ad3ab-669a-4529-96fa-2dbb28791a6c@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <c94ad3ab-669a-4529-96fa-2dbb28791a6c@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: fb47f30a-4bf6-46ca-dc86-08dccce3956d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjZKQmNTZ2Z2b09mMHJVRHZ1Q1Y2SlJoUytiQUpOVUlsYTZjRjZuWjgrYWt4?=
 =?utf-8?B?Slc3bkVENWhPKyswZUhtZGp3SGlhK3hyWDdmK2RzQkhLS1lBN0xEMm9HR2la?=
 =?utf-8?B?MzZUK1ExUmppTXVXcWQ2UFZqM294QUYwMHJHSHc0MU80VWZJdUF2VHRRR2lG?=
 =?utf-8?B?VUtKZnZUbitiKzlFaUJmbVBJSFdjZmNoUTU3NktmWWFvN29PZlJPbmhJVzAw?=
 =?utf-8?B?VGV4MmkxVDZoK2lBUHBoVVNDYWtZcmZ5d2RSZkR1bkhuS0Z2MEQvanViSWV5?=
 =?utf-8?B?ZFRtb0pON2JVbU5ncEh0WDNjT0cvMEYzOVgyOVlkcXcyL1F2TmNycld2MFFU?=
 =?utf-8?B?cTg2NmdrcWxaUzh4Tm1xZ0c1eFBnNnlRYnRXaldleUlCRmlNYWZmNmcyRFU3?=
 =?utf-8?B?V0hOYkIwU29nSUQvNURZQmhHekRMRWhLUmJHVUpYc2Y0OE83RjNyOWJVTnpa?=
 =?utf-8?B?Y2IxbkZXRExzWWwrUWdIRzJKU3Z3bzFzN2k1TktpK09wQmJId2x4cDh2RSta?=
 =?utf-8?B?WVlBOE9hOEVOWElXMm16d1pkRFVINmN0cm9BcHNrVkJzMWtOTTJrN1Fpam4y?=
 =?utf-8?B?LzQ0MXMxZnhrTGdhL0JCNVhUL1VNMmo0UTdGSTBnTEZPQTUwS29qSHJ5Q2Ri?=
 =?utf-8?B?RUE3cndoZHlxWGNtY2F5d0JzdnE5UVdSY3hMcTZwTlZJYzVzOWJTU2UwVlNP?=
 =?utf-8?B?aVRrbGlRamhSZkkxck85R2lTMUJsUkNCTXZ0N3paV2o0L3J6QzRMcTZYemRx?=
 =?utf-8?B?LzhkeHR5dm1mdG5vV3lQRm5KeUdtY1YxRFd1akNTcC9WaU81SEc2bzdQcERl?=
 =?utf-8?B?eXR5OGtJN0p5eXBLYzF4SkQvTFlCNUV1aXRJYWR4c29mUXZCbUVMYW10K3lr?=
 =?utf-8?B?b2FLS3VPUHA4YkVnZjNpdnJDTWdjbG0xMEx1a1ZMb2twaVRZMHd3aW5HbXdk?=
 =?utf-8?B?b1I2bUc1bkJpbm5EeklERmNTYVMrdENLSE4rcFk0eHhERHJWd3RtK3ArRDY1?=
 =?utf-8?B?MVhYMlRBMFJjZzRGMmVtaXNIbm4vYkoyeW03VzJrY21ETE5vNlFZRi9lVmgy?=
 =?utf-8?B?aEpSRmxpMlNreDVkL041b3BDK2pZU3dPb3F3dEkvaGtLSEtISy9FcUlYcFlx?=
 =?utf-8?B?aTJmTFlBZVpQN2VYZVlvTUJvUFcrTDludGFWY2g4Q01KbEFvM2lzSzd4dmVu?=
 =?utf-8?B?Ri93UE5RekYxb3RoYVhWcVlJRlhvZzhGY0NEazdidGlvNDlUWGhJRnc3QVg0?=
 =?utf-8?B?NFBVTlJOTUxGUnR1MXB2TnVHUWs4dUpjZC90L3RwK2xwVzJRN1ZhdEw0am5J?=
 =?utf-8?B?RGlYVFEzNzlxZFlMMGkvSHdMbzAxSHQyNzlDRzZ2dHdpb1hDYm55andIVytN?=
 =?utf-8?B?Y2htZWdiM3VFRk8remtnOWxmTHFUbzJLVk05ZThkek4zMXoxS2laaWtSTy9p?=
 =?utf-8?B?WnYvd1A1bzRUeG5pVlcvUlJYWWtUZlNzWjRpMFZORk0zRDVPa1VLckd1U1Fa?=
 =?utf-8?B?cU5lNnpQb2p2MFRQTzIzNG8vaHN4NHZJcFRqZ095a3pqSDhiWUV4bE1KYlgw?=
 =?utf-8?B?N1hSZUVmMXNxTldmT2k0TENGcUtYRnNnRjBSTjd6bmVBWU1kV2lVWDFWNkZJ?=
 =?utf-8?B?bS9wcFI5bWlqT0VucmJKVS9DeC9nWFpUa25WK1pmZFdRanNmZGJYYVRrK3VD?=
 =?utf-8?B?THVjaEt1SHN5eGNyQUdYTHVlWmxWMUEvMnlSM20ybjRsSElOY21mMk5HOWR0?=
 =?utf-8?B?WUNTUGFTZk9yeVN6WG5DY1VYeGFYTmx5djc4b1hNOTR4ODR4Q2RaNVhTejds?=
 =?utf-8?B?cWpObE12MTNpRzUrczlYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhBemVreDJhSWZwZEJmVDBmVU5qcGkycEVlVm5YMHNCZm5HVHNsQnREcWEv?=
 =?utf-8?B?MU1qYktuWU1hUUpLL0dvNG5YMHpaUmI1RmIzT0lySCtWZVc3LzVXdDI4bXRD?=
 =?utf-8?B?cnZKcTdFM1BlUDV2cTB6QVhGTjJFSkV0NitXT0NKZVFFY2lWV0xqMTIybWc4?=
 =?utf-8?B?R3hKRS9KL0pJZXRDSUx3R21zQ1IzaVV4dDhEM0JmZE4rRUNjc1RDanJLYUhW?=
 =?utf-8?B?MHZ2enZOK2QvVHhaeVVSeEZJT09DaFFiRlkrQU83MkRTRFc2N1RIM1UxTE1x?=
 =?utf-8?B?V0lzQ2xwMnA2azlialIvZU5GdFoxT25wL2Y0YWgrODg5eTJDeGplTWdmWmVV?=
 =?utf-8?B?RThtUC9uengrUE1XbFRoNVY2Y05DRDkxY1lMa2ZWbW40NGJlVmVFU0d1c1lv?=
 =?utf-8?B?MEdkVlFtY29lMTlmVG5QSU1QTkVHM2ExZzMvNlJYYW82alJoSmpvR3hBY0R3?=
 =?utf-8?B?WlJ0Vk5La2xrYVBnV0J0b1AwUndGbWVDNm4zMmpPNk5Sbyt0Z1Rhdno5Mysx?=
 =?utf-8?B?YUFFWi8wMk41NFppMGcrZURwL3FScDJIeHBBZDc4aXhaUUwxQjVGanRLVEFn?=
 =?utf-8?B?eEI2Qjg4OFpvYS81RHkycWxLaHh5bVdSQ1IrS2dkeWRwbHA0N1RzZXEydEZJ?=
 =?utf-8?B?d0FyQ3pzS3ZVS2NUMjZNRUVWM0FXSEYwdk83UkkySno5OTM5azAxWWtNT3Bq?=
 =?utf-8?B?d1RDRDNYRWVNZUZremx0VWZCRXhqRUQzNG9qRi9MdkVSTkFyRDBzdXkxQ0Vq?=
 =?utf-8?B?VCtpY1JoZWc1Z3FvYWpZLzYvRG5ldVRScUZVbUtxdy9CSDFYU0w0VE9Wanl4?=
 =?utf-8?B?cllQQ1M0USs4SmNkREJ0cDgvclpCbko3T3l5WXdENXhNZDE4eWtaSCtGUGFU?=
 =?utf-8?B?QnB1Z2lmdU5OZ0VWOFgxUEEyNVM5MlZRMEpJOEN1blhaZS83b3NEVGVkYlc5?=
 =?utf-8?B?MzJMNlJ3bndLUjQ0RE45dngzbVJ4WUJhQjV6YmVwN1BNSHdtME16eVAzVUhO?=
 =?utf-8?B?TjNWMWZDVjMyekUyKytDNmp2VFQvZXFQcHN0WnFwZTh1UU5qSUt4NFpkNTJV?=
 =?utf-8?B?eVRUekwyS1ZZb1ZBbVRoRkQ1T0FQRHNKNm1DQTFmem5LTE5nU2FwaEJ0b1FB?=
 =?utf-8?B?SHoyWS9jZnN0TU9hZVRoTm9GSVM1Mm9NTzUxU29FT3pmQ2poMUtLbE51ZXFQ?=
 =?utf-8?B?bERqRVFLY3ZuTXFEd2o5MHljS3Vrcjc5MDFKaGU1S2t2WHBGMU1PR003c3Zi?=
 =?utf-8?B?TCsrS3VQUjBvWjU1d3NtT3FXNCtkZk4zR3k2czl4dTQrOUNUZ0RRcEcydWdS?=
 =?utf-8?B?L0ZnZUNLSTZWa0Z1Q2xtS3RDMUkyVVFtbWhDcEZmZ3J4SjlhL2FZTkNPdUtB?=
 =?utf-8?B?NzZMcVZFanRDaHBrQWhORmF6UVVUNnpRZFJSS01saW4xWUc0K2VXS2hYZVpB?=
 =?utf-8?B?eVdmT3NTZ2ppNHp6QzErc2lsSUFPNitUNzl4bVZ0enljQWY2dzUzSWpmZVhj?=
 =?utf-8?B?THR1enVnVDI1d1AxRENRMCtaSG54L001aWc5NXIxd3VmMU9iK2ZDcU5zQ0tp?=
 =?utf-8?B?VFBZemZ1VHNTc1hHQ25RMWJQZlFaaXhWMjlSRVhtUlgxS0ZRSXJsNEFwQllH?=
 =?utf-8?B?Z3FnOGdqYXh3cUVUZEdheDl1UHJwMExKRmNDTHR5THVzTzJ5S2hJZFZJaG44?=
 =?utf-8?B?MXYwS2xpdHA2RlR5WEpUbUIzQi9uWGNRdU9vOW5XaFQzWmkzSVQzaUNIREF3?=
 =?utf-8?B?dmlEWnVJSC9PT3Ixb0pIRXpTT3dwVUFoV3lWYzU5N0ZSRGVZeXo4VTl1SGpr?=
 =?utf-8?B?anhkQ3N2dFNld1E5QkZKelhTSU1neWpDcGVFWXpUNC9CMmFSUGNCRTN3eHdS?=
 =?utf-8?B?Q0UxUUVRREh1Z2xpYWNtREZaN2VMelFLemtmQVhwbzJtSG1ndFdYYUZtc1Zl?=
 =?utf-8?B?Q1ZkMnFZS25iK2M1Y0ZJUStpMm40R3E1YnI4dVd1VVhhVUZvcHpJNnI2Rk9P?=
 =?utf-8?B?Ym0rZ3ZadkNYUW9VNndUWC9uUnJEWlJac3ViSnkxSnJGZFI5TUZ3bkM3MGpm?=
 =?utf-8?B?bGRoS1p6dm4wMUNPSXIzTGErTnkzc2FaVm14SDRYdVpwQVAyV2RYQnhNR2Vn?=
 =?utf-8?Q?md/U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb47f30a-4bf6-46ca-dc86-08dccce3956d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:15:01.8369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0IbHK4r4oOxifOFds3C96C9iQQeKDmv/vgAiO7LievF8Wi13t0ffipAihiQWv+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-09-02 05:06, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c94ad3ab-669a-4529-96fa-2dbb28791a6c@amd.com">Am
      02.09.24 um 05:03 schrieb Lang Yu:
      <br>
      <blockquote type="cite">Fixes: 5a1c27951966 (&quot;drm/amdgpu:
        implement TLB flush fence&quot;)
        <br>
        <br>
        Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:lang.yu@amd.com">&lt;lang.yu@amd.com&gt;</a>
        <br>
      </blockquote>
      <br>
      Ah yes, that explains why CPU based updates doesn't work reliable
      any more.
      <br>
    </blockquote>
    <p>My understanding is amdgpu_vm_cpu_commit increase the
      vm-&gt;tlb_seq if needs_flush, so this patch only fix the tlb_cb
      memory leaking issue.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:c94ad3ab-669a-4529-96fa-2dbb28791a6c@amd.com">
      <br>
      You need to add some explanation to the commit message, e.g.
      something like &quot;CPU based updates doesn't produce a fence.&quot;
      <br>
      <br>
      With that done Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
      <br>
      <br>
      <blockquote type="cite">---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
        <br>
        &nbsp; 1 file changed, 4 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index 1d46a5c81ec4..f93804902fd3 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -908,10 +908,12 @@ amdgpu_vm_tlb_flush(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = params-&gt;vm;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (!fence || !*fence)
        <br>
        +&nbsp;&nbsp;&nbsp; tlb_cb-&gt;vm = vm;
        <br>
        +&nbsp;&nbsp;&nbsp; if (!fence || !*fence) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_tlb_seq_cb(NULL, &amp;tlb_cb-&gt;cb);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; tlb_cb-&gt;vm = vm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dma_fence_add_callback(*fence, &amp;tlb_cb-&gt;cb,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_tlb_seq_cb)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_tlb_flush);
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
