Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2D3C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63E010EB13;
	Thu, 22 Aug 2024 14:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Leif+Y5e";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE19C10EB13
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js/Zc9t7KeED5BliwEnTuwKtr0B8nsNpS7zTGlFt7K5ekutIqKey0aymdOV9ZouBN4dDf4ry5348nZUU6zXMsIliT2rPuxrWlP3fpSaWd7jhUsEB7soiEyVH+LnNzlHMhNl3ozufdPY4uHSsdWHciqf3pnlEh6b/ITGVpALJvoGAx3F7hz++BYP4gYUzUM263EHaqBqxTe1G4qTiHw90qwtDjRJqSwj4dIzg6ishdmpCW+XQ3XP2vdDQjGKDFVkSiz+69g+k46aoU8pIjduJTkbhSYf/3UuwAtiXn5QLbfrd3M3mlCLneQ4jRnAnwH49X9JkAqF6nx+cVFzQzZGDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxtoVAGROdDSoSO3aSgmdmiiatS//0/oRvf791fzhFQ=;
 b=XvrCg2ld1zPCr7hluoMQnVzCeihhuymB0cMQ069f2U2mi3Ebz8fPjldzwihIgDgogHF2Pj19wzHRWGnpbiLc1SfH0gsLKOYTz0wW8AVElcNFmOB2WITh8KiJYLTNZ6Y+EnOUfY3xAp1xqKnD4WcRKJ3B9tqVThFte+mi0rMorz7jMQxGmo08LRNkAzDdJandzzAo4EbG+J9ti8M86eIzrBnAL64Y/KKuiOdwdzDtqSb7zevELF4A85Y/83p28OA+DUSMrPNWC53+s2nluw8Dav651b/412bNBvp5mKUWE2sQgg/zLPTQ2m3JNroYVGgeeDJBtAJYP6xH1xxFGbnCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxtoVAGROdDSoSO3aSgmdmiiatS//0/oRvf791fzhFQ=;
 b=Leif+Y5eRT8VyFu70rHIZRjFExNsTvUgRsX8l0uhfTN7EfQY3972sbSa+4bFOOJtrlXFQTRAxi3d18IfeOUPsAh6jar7HRemZZQkOE416m0GTWz6MQqU/9jUuU6N/7zQmxT3qpQGyQwoPp7sChXqlpq7VZhQH9mLflD26ceDj/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 14:58:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:58:48 +0000
Message-ID: <b5397450-be86-f962-9547-990028ea12ef@amd.com>
Date: Thu, 22 Aug 2024 10:58:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Document and define SVM events message
 macro
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240730201547.13590-1-Philip.Yang@amd.com>
 <20240730201547.13590-2-Philip.Yang@amd.com>
 <a2a196c8-7861-4c0a-92ca-d082f7ff3fcd@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a2a196c8-7861-4c0a-92ca-d082f7ff3fcd@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd6ee40-d1c7-4b05-6d1a-08dcc2baed46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW5tbmVhLzcvWk9tV1REeTkzNXV3Sks5bzMxd2tLK1NjKzFNR3UwMzBJczJT?=
 =?utf-8?B?cEFxd1kwbWhxdzBPTzJQNzUwK1luZUhkZUVKelkxN2RzczM3VlhoRGJJRHdu?=
 =?utf-8?B?Z0cxb2U5R08xRkhzQ1JVMlNiV0s2Zko5d1A4cFh1c3NHQXNmZlF6TFZiYmZx?=
 =?utf-8?B?OC8yQTIzZ1FDbHhnREtGTDBFa29yVFJiYzJGQ0lPUy9PYUczSkMvWDJRWHFw?=
 =?utf-8?B?T29PNjljSVhTWGJ2bGtlLzVQYUZ4cTQzbVdINEFhc0pkVnoyNFAwaGVDM1Uv?=
 =?utf-8?B?NzlWekNwclpDZnRPMzJRQXNGRzNZTnJzQTRxd2JrdDlYdlpnVGkvMUcvOCtW?=
 =?utf-8?B?OTZaTWxnaGdvbk1vSHRRcGJGV3JwR0IwWitVcWM1MG9OUG9LK25aaXJnNXhW?=
 =?utf-8?B?dHlwbzF0TTdMdnFVdEIvL3owNHRxZXY5K2VUV0N1a1h2V1k5bTAxTmNsYjNG?=
 =?utf-8?B?cG0ycFFDa2FDTnVDK0RvTTJpQk1CS2hxejJkMkFNOHNtaFNLdXlKcFZ6ODFo?=
 =?utf-8?B?NHhUU2E4VUlxa2Exckp6NkJ0b3NZVkFpeE1SR2tVR2Y1VVlSNVFZc1pHLzh5?=
 =?utf-8?B?MTQ4Nk91OEhseGtvRlpXM2hUNGtWYkNna2c5LzFZN2lhcWRQeWxjUlphWThZ?=
 =?utf-8?B?bDVJU2IydHR4aGNDUUVxYVBlRVBTQjdXdTZxaEVkVDNCd1FkMWdLRW8wNm8y?=
 =?utf-8?B?WVU0QVlhdExZYXRNbmdEZzZZOTFSblZ1UktpekRzM3VRUkFKRkV2MHNGV003?=
 =?utf-8?B?R1lMdXV3UnVDcmU0RnZjSEFNL05PYTRqYURaYlF3bUNiR1NsVXc0ZnlPZ09K?=
 =?utf-8?B?bWo3MXFvdU1JU0tLVnc4OW5ScitzK2QxNTZmUzhJcDdjMC95Y25JWlRVVUw3?=
 =?utf-8?B?c0R3ZTNiMmJQSWk5MWdKaDVxL3ZLV25EYUw5WExDcDd0NTBPV21jT3R0ZE1T?=
 =?utf-8?B?SW1yU3F3RXV3UUJvclFjTzFkbUo0WTMrNGRKSzJwQlJLaWQzUjdUYmxGT3JS?=
 =?utf-8?B?VkJGUGtHQ1JZZVFyVU80bUdudHF5aTlIN3p2WXRuM2ZOSHhyL0l4dlBYVldN?=
 =?utf-8?B?QkV5MlBUWStHL09SWitGN3V5Uyt1cWdtdnd1cFFXdFZWNVJiV0V1aThnRm5a?=
 =?utf-8?B?RytBSHFwOEpqRWpMN3Q2RktYVFl0VTZvSllXY1UzSWNwVFhXV01CN2NZckoy?=
 =?utf-8?B?KzFXRVFWVHVvcFdiNVo5eWJOQ1BVNTl4K3lrc1U4MEVNdXB1eFFaeXRsNW4r?=
 =?utf-8?B?ZUducEtJYXhHOVJxSjZOR01rL1lCTnFXdUhoaGNCZisvRW1pKzB5Vi9ORXJu?=
 =?utf-8?B?a3NyZUJOcEFSaC9hdUZCMDdMS282TFI0b3BBejRrRG15dHZVOGREOEUrR3NV?=
 =?utf-8?B?azJ6enRMdFQ4bzhDU1BMcmZWc2dJZGt6RTI3OXdJYVJtbk1NS1BkVHJTZW5N?=
 =?utf-8?B?TCszTTJJZC9MQitJU01iMFZRKzJrOVlBL2tWYWxEZDFoOGpiSG5uV01wem1o?=
 =?utf-8?B?dys3SVNCTGVrRVluN2prWWxSdFd4TjlPTFNCWjFxN2p3TTIwOWxya3Z3K3ZD?=
 =?utf-8?B?TjBxRHUwYkRYMDFySjl1NS9adVhzQkVQUERKM3RTbUhYWm82blg3d1JvZURw?=
 =?utf-8?B?SkxKd3ozU2xRNnpqbkxjNjkwMG15dVRialB0M2lxUFpPZE9GMVNPZG45K0tk?=
 =?utf-8?B?WHpHSnJuMVRQYlhwZ05lZUM1bHRpUjJ5WW96NWlRbWZCY2FuQnZnTE9rUXRr?=
 =?utf-8?B?ekxwM3ZaYUdBNFN6cTF1MEVyTHZNVCtQMjdqSW9mOUFZMk5jTlBmNGxaSmVw?=
 =?utf-8?B?a1hsOEdiQWozTS9KSkU5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVp3UEhSclI2b3dqdUJjZENjQnFzbk9mUityU3krZzVaTzdkTjB0MURRRVJ1?=
 =?utf-8?B?SmIxdVhqMTVMYUFLcFVBSmVvTHNqQ1lHUVJUdmpHaHRub2lPU21QblhQV29n?=
 =?utf-8?B?WkZJRDR5WldkdjNjZTU5bkE4TTFWdjVWczRRQmhtd0syN3MwRUh1QnYwOXhP?=
 =?utf-8?B?TlhBRlh2dkpYNkJxZmhhMW5TWHdEUlhtWXJWYkNrSmdUbGhPemV2eHFXMDcw?=
 =?utf-8?B?L2lxQ1pDY0t1alhYTko1Tkl3UUhzMm1oQ0h1TEo3QURnOTBVTmhPMllKaUVz?=
 =?utf-8?B?ZmVLYWFzN3hXYXNqM0RCaDBab3ZWU1NzN1dHL3BFR2FjbUg3cHhtcWxnZ1l1?=
 =?utf-8?B?MklzUkhweFYrWFBKMmo1cU9jWnNyMDUwTUI0Y3VJbUwraUdZQlQxTUpFRG5K?=
 =?utf-8?B?b0h0MlRtenRtQW0rWnpFVzBKTEZuYmx2VjEzRUd1OXpQT2p4aWtkSklSQVNy?=
 =?utf-8?B?OTExbWljbzNsYklPTmNxWjVJYUNDcWd2SFA2T09jVDRtb1hHN091V08yU21R?=
 =?utf-8?B?aVVxOEhJcXd4SW5JWXp5b2RNaHVTZzNoWHVhN2NkRnhTcU5vZU5id0Fya0pR?=
 =?utf-8?B?THRDeStWcjRiVUsrUTJLSUorTGFmdWRrN2JCdk5aNGZicWlzQ1poV3Y3VXdv?=
 =?utf-8?B?VkdGUnRvVUFGbTJDOU9LdmVrTis4eThFR0Q2ZnZDcDY0RDdBZjFVeFVVWGhj?=
 =?utf-8?B?dUhLSFJORGlSa1hWUWg3WmJyNFNaSDdyYUlqZkRFSE1VQlZhS2VuelNiSGVv?=
 =?utf-8?B?em5VTGI5aVM3czhYbklkMHh2V0tIL2RiYTRvOVREZXpSRkZKSnlxdWRjU3V0?=
 =?utf-8?B?MnRnY1NYaHpDSHV2TU1EeklacnlkTWs4bUxJUCt5dS9vYXpHK3NIaG5jSkor?=
 =?utf-8?B?ZHV4bnh3eVh4NDRhbWtZRk1tU0NqbUM4RFphQUo2RHZTaGM5NEZZQVFLeWdq?=
 =?utf-8?B?Tk5mUkkxMVg5M01WUE9CWW1KbUhZc1lKSGNBYjdzREtVdGcvRys3MTBwMEJz?=
 =?utf-8?B?R0lLTzhyRkVKNEVKRk1scXl0ODkwOEp3MzhwQ1kzb2UzRnFNY043blNhSEVq?=
 =?utf-8?B?ZUc2Y2RkblhjeC9wcEVIeVhHcFhlVzNVY2tleDMra3hBaGlSSGx3TzZ4b0Q4?=
 =?utf-8?B?bjMzcnZTdGV3UGVqbGZSendhQ0J4SVUyQ0hDckZiQ1Fjd2tvTGR0U0JrZE0v?=
 =?utf-8?B?TEpGbWVvY2lDTy9WcFlwaFFDMmFKVUpvaTYzWUZoMUcvMjA2d1BRUm5PcFU0?=
 =?utf-8?B?cUJGbk5hU1NCZm1WQTdhK3l2TXd1eFFEa0x1S3VNS21Sc1NsM3AyQTlKekp2?=
 =?utf-8?B?RzlubVl4TXRkTGFqYnpZOVFjSmw5T1VKbUgvY3I3QnhwSTBRVUlWWmt5eE9F?=
 =?utf-8?B?Q0pjamt2V28yMnpXRUcrSFZDYjMvc1l2U2xCUFFaTHBkNjlqc3Zna1BMMHI5?=
 =?utf-8?B?Nlo4N2VQZDlXMmllTFJKSE9oRDF2eDBMMGlTbWhQNitWYjduV3l1QzV2T3Y2?=
 =?utf-8?B?THl6ZHlQT0dmTldMZXk1Wk5oQnVKUE00cXVTRzM5WklwbUlPc3JRRnV0NVhr?=
 =?utf-8?B?Z3VRenZSajV6cTNHeE55THIrLytVMlBvQnluTU9lTXAwY1VlUTh1elJzc1o3?=
 =?utf-8?B?bmV4QUwyeUR5TEtFS0hqcVN4ZE1HM2FkRFdSbzNUUWxVMnBWZDZhYkVoSkts?=
 =?utf-8?B?THF6VVpDV3lNTUxFdCt2REIrdjgvaDZ6UFBJU1dDWFdoNE41OTA2ZFlxY2NK?=
 =?utf-8?B?U2N0RU5rZXF1MGF2cUF3WjVIQndHT0JIWWo4Q1JxWFlOcnZnV2RIOE1SenRF?=
 =?utf-8?B?a3kzTklYUUh6SGoxMkJZU0dKaW5lM1ZrQ1ZJMXkvWk9iS1NOVTBOd0VvZ0dY?=
 =?utf-8?B?UUwvSHZSdzd0L1ltV1VZNFBHbGhjNXVOM21QWGkvVlBBeWNoMy9YczJEWExt?=
 =?utf-8?B?dnFIRitoVWl2NlhwRWdqeUYxaGNidGo2RGJZajV1UVRUNXVIY1piVEoyV2ds?=
 =?utf-8?B?R2pHOTVDVm5oRnJ1ZCs5dVZMazJ5cEU0a1BnRjJPWFJHbWRCQnBlNzU4TVI0?=
 =?utf-8?B?Zzl0Zk9JZ0d0bXR6TnB1d0VaVmpuZDlyOWh4aDRLUXVaZ0RQTmM0anpIOVZE?=
 =?utf-8?Q?3aTU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd6ee40-d1c7-4b05-6d1a-08dcc2baed46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:58:48.1373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ7GR866/7TaAmyOu2O766YA+/P0NoL7zG3z9sUPPPNP/mAV0qWrkyuaw/0POLLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
    <p>
</p>
    <div class="moz-cite-prefix">On 2024-08-22 10:32, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a2a196c8-7861-4c0a-92ca-d082f7ff3fcd@amd.com">
      
      <p>
</p>
      <div class="moz-cite-prefix">On 2024-07-30 16:15, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20240730201547.13590-2-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">Document how to use SMI system management interface to enable and
receive SVM events. Document SVM event triggers.

Define SVM events message string format macro that could be used by user
mode for sscanf to parse the event. Add it to uAPI header file to make
it obvious that is changing uAPI in future.

No functional changes.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  45 +++++----
 include/uapi/linux/kfd_ioctl.h              | 100 +++++++++++++++++---
 2 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ea6a8e43bd5b..de8b9abf7afc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -235,17 +235,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
 		amdgpu_reset_get_desc(reset_context, reset_cause,
 				      sizeof(reset_cause));
 
-	kfd_smi_event_add(0, dev, event, &quot;%x %s\n&quot;,
-			  dev-&gt;reset_seq_num,
-			  reset_cause);
+	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
+			  dev-&gt;reset_seq_num, reset_cause));
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, &quot;%llx:%llx\n&quot;,
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, KFD_EVENT_FMT_THERMAL_THROTTLING(
 			  throttle_bitmask,
-			  amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev));
+			  amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev)));
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
@@ -256,8 +255,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 	if (task_info) {
 		/* Report VM faults from user applications, not retry from kernel */
 		if (task_info-&gt;pid)
-			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, &quot;%x:%s\n&quot;,
-					 task_info-&gt;pid, task_info-&gt;task_name);
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
+					  task_info-&gt;pid, task_info-&gt;task_name));
 		amdgpu_vm_put_task_info(task_info);
 	}
 }
@@ -267,16 +266,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    ktime_t ts)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
-			  &quot;%lld -%d @%lx(%x) %c\n&quot;, ktime_to_ns(ts), pid,
-			  address, node-&gt;id, write_fault ? 'W' : 'R');
+			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
+			  address, node-&gt;id, write_fault ? 'W' : 'R'));
 }
 
 void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
 				  unsigned long address, bool migration)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
-			  &quot;%lld -%d @%lx(%x) %c\n&quot;, ktime_get_boottime_ns(),
-			  pid, address, node-&gt;id, migration ? 'M' : 'U');
+			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
+			  pid, address, node-&gt;id, migration ? 'M' : 'U'));
 }
 
 void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
@@ -286,9 +285,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 				   uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
-			  &quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;,
+			  KFD_EVENT_FMT_MIGRATE_START(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, prefetch_loc, preferred_loc, trigger);
+			  from, to, prefetch_loc, preferred_loc, trigger));
 }
 
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
@@ -296,24 +295,24 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 uint32_t from, uint32_t to, uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
-			  &quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;,
+			  KFD_EVENT_FMT_MIGRATE_END(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, trigger);
+			  from, to, trigger));
 }
 
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
-			  &quot;%lld -%d %x %d\n&quot;, ktime_get_boottime_ns(), pid,
-			  node-&gt;id, trigger);
+			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(), pid,
+			  node-&gt;id, trigger));
 }
 
 void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
-			  &quot;%lld -%d %x\n&quot;, ktime_get_boottime_ns(), pid,
-			  node-&gt;id);
+			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
+			  node-&gt;id, 0));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -330,8 +329,8 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 
 		kfd_smi_event_add(p-&gt;lead_thread-&gt;pid, pdd-&gt;dev,
 				  KFD_SMI_EVENT_QUEUE_RESTORE,
-				  &quot;%lld -%d %x %c\n&quot;, ktime_get_boottime_ns(),
-				  p-&gt;lead_thread-&gt;pid, pdd-&gt;dev-&gt;id, 'R');
+				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
+				  p-&gt;lead_thread-&gt;pid, pdd-&gt;dev-&gt;id, 'R'));
 	}
 	kfd_unref_process(p);
 }
@@ -341,8 +340,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
-			  &quot;%lld -%d @%lx(%lx) %x %d\n&quot;, ktime_get_boottime_ns(),
-			  pid, address, last - address + 1, node-&gt;id, trigger);
+			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
+			  pid, address, last - address + 1, node-&gt;id, trigger));
 }
 
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 71a7ce5f2d4c..c94182ad8fb8 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -540,26 +540,29 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_ALL_PROCESS = 64
 };
 
+/* The reason of the page migration event */
 enum KFD_MIGRATE_TRIGGERS {
-	KFD_MIGRATE_TRIGGER_PREFETCH,
-	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
-	KFD_MIGRATE_TRIGGER_TTM_EVICTION
+	KFD_MIGRATE_TRIGGER_PREFETCH,		/* Prefetch to GPU */</pre>
      </blockquote>
      [JZ] could it be per-fetched to system RAM also?<br>
    </blockquote>
    <p>yes, will change to /* Prefetch to GPU or CPU */</p>
    <p>Regards,</p>
    <p>Philip
</p>
    <blockquote type="cite" cite="mid:a2a196c8-7861-4c0a-92ca-d082f7ff3fcd@amd.com">
      <style type="text/css">p, li { white-space: pre-wrap; }</style>
      <blockquote type="cite" cite="mid:20240730201547.13590-2-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">+	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,	/* GPU page fault recover */
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,	/* CPU page fault recover */
+	KFD_MIGRATE_TRIGGER_TTM_EVICTION	/* TTM eviction */
 };
 
+/* The reason of user queue evition event */
 enum KFD_QUEUE_EVICTION_TRIGGERS {
-	KFD_QUEUE_EVICTION_TRIGGER_SVM,
-	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
-	KFD_QUEUE_EVICTION_TRIGGER_TTM,
-	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
-	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
-	KFD_QUEUE_EVICTION_CRIU_RESTORE
+	KFD_QUEUE_EVICTION_TRIGGER_SVM,		/* SVM buffer migration */
+	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,	/* userptr movement */
+	KFD_QUEUE_EVICTION_TRIGGER_TTM,		/* TTM move buffer */
+	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,	/* GPU suspend */
+	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,	/* CRIU checkpoint */
+	KFD_QUEUE_EVICTION_CRIU_RESTORE		/* CRIU restore */
 };
 
+/* The reason of unmap buffer from GPU event */
 enum KFD_SVM_UNMAP_TRIGGERS {
-	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
-	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
-	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,	/* MMU notifier CPU buffer movement */
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,/* MMU notifier page migration */
+	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU	/* Unmap to free the buffer */
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL &lt;&lt; ((i) - 1))
@@ -570,6 +573,77 @@ struct kfd_ioctl_smi_events_args {
 	__u32 anon_fd;	/* from KFD */
 };
 
+/*
+ * SVM event tracing via SMI system management interface
+ *
+ * Open event file descriptor
+ *    use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return a anonymous file
+ *    descriptor to receive SMI events.
+ *    If calling with sudo permission, then file descriptor can be used to receive
+ *    SVM events from all processes, otherwise, to only receive SVM events of same
+ *    process.
+ *
+ * To enable the SVM event
+ *    Write event file descriptor with KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
+ *    mask to start record the event to the kfifo, use bitmap mask combination
+ *    for multiple events. New event mask will overwrite the previous event mask.
+ *    KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS) bit requires sudo
+ *    permisson to receive SVM events from all process.
+ *
+ * To receive the event
+ *    Application can poll file descriptor to wait for the events, then read event
+ *    from the file into a buffer. Each event is one line string message, starting
+ *    with the event id, then the event specific information.
+ *
+ * To decode event information
+ *    The following event format string macro can be used with sscanf to decode
+ *    the specific event information.
+ *    event triggers: the reason to generate the event, defined as enum for unmap,
+ *    eviction and migrate events.
+ *    node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0 for system memory.
+ *    addr: user mode address, in pages
+ *    size: in pages
+ *    pid: the process ID to generate the event
+ *    ns: timestamp in nanosecond-resolution, starts at system boot time but
+ *        stops during suspend
+ *    migrate_update: GPU page fault is recovered by 'M' for migrate, 'U' for update
+ *    rw: 'W' for write page fault, 'R' for read page fault
+ *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
+ */
+#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
+		&quot;%x %s\n&quot;, (reset_seq_num), (reset_cause)
+
+#define KFD_EVENT_FMT_THERMAL_THROTTLING(bitmask, counter)\
+		&quot;%llx:%llx\n&quot;, (bitmask), (counter)
+
+#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
+		&quot;%x:%s\n&quot;, (pid), (task_name)
+
+#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
+		&quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr), (node), (rw)
+
+#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node, migrate_update)\
+		&quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr), (node), (migrate_update)
+
+#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from, to, prefetch_loc,\
+		preferred_loc, migrate_trigger)\
+		&quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;, (ns), (pid), (start), (size),\
+		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
+
+#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
+		&quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;, (ns), (pid), (start), (size),\
+		(from), (to), (migrate_trigger)
+
+#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
+		&quot;%lld -%d %x %d\n&quot;, (ns), (pid), (node), (evict_trigger)
+
+#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node, rescheduled)\
+		&quot;%lld -%d %x %c\n&quot;, (ns), (pid), (node), (rescheduled)
+
+#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
+		&quot;%lld -%d @%lx(%lx) %x %d\n&quot;, (ns), (pid), (addr), (size),\
+		(node), (unmap_trigger)
+
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
