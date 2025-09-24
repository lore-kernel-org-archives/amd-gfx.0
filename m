Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82235CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D03710E7FD;
	Wed, 24 Sep 2025 21:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/sY4pMG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C330510E7FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AExpZRk3CR41QsyvQCgNwV02eC5brgKxLw88czoIncnwzowP9twQaQXtTx/o9ySyXFE4ze9W5rpSf1QTqupxoTU7fkUwPucNeFoy+Q4vZiKu8ddRSXJ39d3HP6aXlsdSp5www0rx9KkGHP9mjoNi0MCMMjkRmS+jeF5RA9azcr1eof5iDHWU9QqXYmYD57qQ3VXAcn+kOUZ8W6XEHzTmLu7sAEaDHRay8hqcI5jkSWkTIPICatI/lengcNYD6X7PcmhJMk0iamtNHCzNgVMVj0ADxLe/ku60fFWaueuvRxKXfa2hgHfx9kWSoOyGCzlAyxCXgxuqcTAfqiY0SAAbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6rMhH7QjR4rRglvLhbUbZOWx2Cf+xsZFUZOCxG2q9o=;
 b=EWgxfbmyi+8/03rnqUiuBrebotraq59GPkMif5bdtJKyovdePExAKEvtoQ4kIKOkhCjwvo5pKITF7fAAdiRG5C3MnaoLfOVJSw5mK+j02uKQcrfdhGt25Sx02XMteuZja3nZJJK1ZSnrUzOnoTeQ9w+wLpXydwRE93gsVjSb5kaZywfEGaPAhs1r9fYKTrAlR5wI6sLh5BcllAQbVGLti6ei+tWEoraI5epvExJ1MCDNb7oIeN0vOL+5vIpjUoO8WqVHUqBff05mVBmghKEhYWzVbVpg874EoWHaaUFbH7G0em+N9o3PTxIF8ijZy2B1QkfzUIvPp8dFcaebLd1iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6rMhH7QjR4rRglvLhbUbZOWx2Cf+xsZFUZOCxG2q9o=;
 b=E/sY4pMGB3Hu6clgAOL8aFJ+vY1X7ttArH+CEC3HJrvVHFoaYqLVT23Dz2tYbnReWgOnKxe3l4yaWM/K6W+6BhIdTf5e2lx/E/6QZQ+n5QT+79E08KB7pX3cCtk+8J52Vq1TlZTeUbRsu37EYUpWcrCHtfLywI7xVGFNwtAmTz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 21:50:13 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 21:50:13 +0000
Message-ID: <08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com>
Date: Wed, 24 Sep 2025 17:50:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/18] amdkfd: set_debug_trap ioctl only works on a
 primary kfd_process target
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-18-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250923072608.252345-18-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 63149a23-e57e-4cb9-3a2e-08ddfbb456e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUFhOEt2NjlhMFZvYjlhQjBsWGtTcTBBTHViaHJrS2ZKNi9GY0FBU3hOYSs5?=
 =?utf-8?B?amg2U0M2U2psQXRmYlRMMHVUZjFINkZleGlmcFkwTkM2MS9jWFZnMERCdUtx?=
 =?utf-8?B?Z0pYRkJIZHcrZkdwV09lRldyZHRCM04ycmY0eVB1K1VtdTJOSk5UUGh1WTF3?=
 =?utf-8?B?QnBCaU9hRnFEVjhvVUdGdVlLL09NNkkyWDdSUG5FTzlzY1M5elEyZDRMdHYy?=
 =?utf-8?B?TGZnc3dXV3FKSzhGNEFvdUVIZm1QckNLWUxYb3hBeFlYTE5yYXNvSU5sK0xG?=
 =?utf-8?B?NUVvUEJxTFVZczg1ZGF0L1B6L1R0eG5JamhHazNwWkpJdG0yaDIrRVovNlM1?=
 =?utf-8?B?bkJua2V6RTRLa3F3QnVPTStRYkFVUml1cHdPR096NnRzSnJvQ1ZuSENNTVky?=
 =?utf-8?B?YXZ0dFpzRG1BQzE4bnM0YSs5eWZxZGRDMUVhVVRQN0c3ZVhaay8reFd2K2Yy?=
 =?utf-8?B?Rkd0RnczMVVSL1pBNGx2TXJTWG5VbHpVTUNma2FtSUhJL2s0RG1jMUFZQ2o5?=
 =?utf-8?B?MDg0ZERjaFhja3lZYjgrUEFTN096NndXaW9WcUdSN3ZQQkhESWEwbEpERDhR?=
 =?utf-8?B?ZmRSU1F6TnE4UlliMmo3NjltTERPRFVZT1ZlcHp6ZTFKTHRiQzBlYjdDTHBU?=
 =?utf-8?B?VUduVzBaclhHeFlyUjBHZm5yVmZTK2tBbVpaeDVEQ3QyUzJaOEgzRVNLV1Jq?=
 =?utf-8?B?bDhOVHZ3R1liUkVHVmVERVhOeHpWWHhpVDl5ZFZmbVZHK09tMUI1UVlLQ2Iz?=
 =?utf-8?B?SEZJWTVpY09HMkFnRHk5cXNDK1V1YUtqbVVST0hwbmJjejlzQjlnbEw1Rmtj?=
 =?utf-8?B?bVZXWHhPVVVYYnlmN0szRzNVY3NSNHhwaVUzNGRWOVd5VEhMbW9HUXRhdGtY?=
 =?utf-8?B?dVlqcTBuU21FWVg0a3oralRidXl2SjF6eEpPeUVCZFN6VlE5SzNnVER4TytB?=
 =?utf-8?B?VFhSM3FFVldreHJYUmljcFd1K0R6VnlPNlVRMFBaUG53clFlRnQwT1Q0d2Jv?=
 =?utf-8?B?Z3BweUU4Q0VqcWErVjV3blV5K2tlV2Z2WE9qSG5Lb3gvblFWSnFEdXdqaXNp?=
 =?utf-8?B?cnVqWEc3NVNKcWtsOTJYWFluaGlURWUyd2xXVm1HN3pVTlNiNHR5cSt4QVNJ?=
 =?utf-8?B?dGMxaHdOamRFZ1c3YjJSUFBkTmVmdDR6a0NlaUgwcE41VzFlK00yek9TVEI1?=
 =?utf-8?B?UVJ6b2x5Zi9oaW9lRnk2Z2JoamR6R29rNzRwYk9yV2t6QitVZG5XbXlOdUg1?=
 =?utf-8?B?N0gvcEtvRmRJZWJNMGUzNThCNHVqSEQwVHY5czBOUCtmNlhjZkJBdThUR3Zn?=
 =?utf-8?B?cHlaWGR2YXVPS3l4dXFpUTVoTExZUGkrcHdEL2lNTFlJNGJkc1FSeEhrdWdY?=
 =?utf-8?B?VlhjZmZJbk12YmUwMEI0Wk80eGxLOHBqckJucXhZREhzNVoxY2g3K2JNQ2Ji?=
 =?utf-8?B?S0Rib3BVakZsWlBvTXp4dTNwTUhSbU0ycFd6NHNwRDZVTU1ZZVBXVjNSWjA0?=
 =?utf-8?B?ZUdEWGZkMjBBaFZGcTZVczNhOHc5MkNUQS9kRVB5ZXhZK2swRkExRXU1Ty9o?=
 =?utf-8?B?SjRYdjB5ekxxcDdxNHVuT1pyRlU1WXNQcStyd1IxQk5EVkUvYmtTaFY3K2pP?=
 =?utf-8?B?QUl3dDhOa2poNTdOVis2eElRVHVnTUs3enJTUHhxTW9CTUJmcTF3NlpKZ25l?=
 =?utf-8?B?YWhSZ091OHg3RGJxdXF0SmNBd29oNk4vQVQvWUVFVGdVVVFOZEJuRHU0L3Jv?=
 =?utf-8?B?SS9TR3FWSVpIQkVQcGczRFhLVGh6bGZDNXNWZnFtRlp6TkxMMlBOZGlFRmwv?=
 =?utf-8?B?ak4vMEUraU1BTGpBUWlYNjFlZ2o5SzN0ZmdQUXZNcjN2cGxqSEtMejdDWW00?=
 =?utf-8?B?UzlidWhBQTAyazBPOXV5VTJuZ1E3bmJ2ZjhXbDVmd0ZJbUtzWjN1blJULzFv?=
 =?utf-8?Q?D/HXTmEDmpA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by82clJjUDlUWlZmbC9GMUhhaXZMb2ZwNU5pWUxwMlkxbG1wclpieExQdkpD?=
 =?utf-8?B?cWsyVmJBSlFMR1FWWG1XKzZ6Z1l2STF1UXFBMVVBdGQ5d2x5Y2U5eXRVZnV1?=
 =?utf-8?B?aW1BNXpNNnZ4M0I1djh5OFlXb0VpdGNFRGpnVEk1MWdSL3oza1gzcVVVb0ww?=
 =?utf-8?B?WjdSOFE5TGNKaDJIaDZrQVRDRGZueXAzMXQ4UzVSU2diTU0rSVdYNVB6L1pE?=
 =?utf-8?B?K1JaNUphWll3VzN3VU1YYytzWEFRM3dIUWFpNElmRlNqcVFBNUQ3b0g4Si9L?=
 =?utf-8?B?UzdwbnB0Z0NtVTgveElIZmZaMlMrWmwySXZpaTVGTTRCZmpPWTNsUFpRaHpQ?=
 =?utf-8?B?UG5FbU9reVdJQzIzMTlSK3Vrb0RoZFhHVzFmTFJVTmpNblJFZHJkeitsTGw1?=
 =?utf-8?B?aEVQOVlVWFI3MmVDRklZZlpsUHBuVEpGVnl4anl5TWZiQkUzKzB4bnJxeVJE?=
 =?utf-8?B?cWRGZ0syVVVwZ2FJaGhnL1l5NGtVL1JEVkFoK1VwYktHalA1ZU1lMjBCaTFz?=
 =?utf-8?B?aVJwSDlPUWJnQlVGa3JzcFByUGw3ZS9STlVhSXl5R3FmR2VFbXFYQjdPYlUz?=
 =?utf-8?B?SnVBU3dhTlFVODR6UU03OWVEWU9pZHlacVJtSnA0OHUreDQ3V1dWb1BCRnZi?=
 =?utf-8?B?VGNESGNhQ3prQlAxbVpkbHYyZlB2MnFjTFY2MnFmNCt3NzhzbURsYVQ0OVNn?=
 =?utf-8?B?Vm9EaEFYSjd1bHdneThEdlNiZXZkRTVaRENRdmFMQVF3dS9CSUpiK3BlakVp?=
 =?utf-8?B?Ky9ZaXZDSUcvN3VNaWlBUW9jdmJZTHVSd3BZZnBrc2Rxcm1IV3A3a0RSMHdU?=
 =?utf-8?B?K3dGSU5YOGx1bmJyNWhoVWxRTWdQc0EyM2s3ZTVoZFBLdTNJcFpwRVFqRmpz?=
 =?utf-8?B?a0dFVTlaa1pwRW85R3A4Q1VQTHkzUHAvRHp0Vm11VXhya3Fvd1FYaE12cVVO?=
 =?utf-8?B?OU9TenUyNnE1V1o3NEo3eXAyYnNhTGQ2aUNnUUV4MmZEUFpyVHI0ZUpJaWVJ?=
 =?utf-8?B?Q3ZiUHVEcjRnOVNkQjZlTVhjdWxkNGRQNEQ2c2NkcXZBUnp1WUdab0I5N2Zk?=
 =?utf-8?B?dXZHYU1MSmxXVHVYckFCL2hlQk5WWVBSY0hQU0oyamxnM2JNajFOTVZKUUlh?=
 =?utf-8?B?aUhvVjlDQ3RmNWVBL0FsR3hUbk5nVDBzZ3BRUnFpVXpjcU0yTHlocmd3djcw?=
 =?utf-8?B?b041dzIwMXZjM0FJaWx0eGxqbHRmbUxITWtaUE8zQTRpWStROFlmb3l3aGRz?=
 =?utf-8?B?QWoyNkF3eW5NaTJ0eE5tQTRrN2RVL0g0NFZ4cTZsOG1HMHZiVlY1bklQQXdY?=
 =?utf-8?B?SERsd0IyZTB5VUlFM0I3WHQxUWVnODBYQ2hKRGJQS29YZnJ5UFRNVzJ0MUdR?=
 =?utf-8?B?TlhydkQ0clIzUEZveDFNSVNvNDFobnVHVURIbXFOL1pmbDJNNXR1YWpHTVFh?=
 =?utf-8?B?b1JObmtGWTR3ejNpVThlYU9xY29Kc1h6YVlLdDVGWGlpVHF2NWlxOU1aaDlO?=
 =?utf-8?B?R1hsZU1Ic0IxVGxmWWhXSXJSWms1MnY2dVFGQXBUZHVHdmxWTEdiWE9vYzZo?=
 =?utf-8?B?SnhnRkwwZS9DaWlYK1pibFBqQXhuQ1dOYXZYRGNORFhzejNvdXlyT3RDeHE3?=
 =?utf-8?B?aElTc040OGt1RVBWNnpoMXoyQTBJYzlkR2ZUV0JLa00xOCtmMFhUV080UjN5?=
 =?utf-8?B?VVBzelhjenlmNHUwQ2VWV2ZzYm4zL215MVF3Y3ptTHVEVi9JcERzNlA5YWtw?=
 =?utf-8?B?QnpCNm8xZTRhbWg1Uk8yZHRpWHo5MXpMODdjNVM1eXhqOWl6Ti90bG1NK0Rs?=
 =?utf-8?B?K3pERVZEMVY4MFJ0bnhHZlpWRmZVMlpxamNvMXlST0kwc084NWJOdTRLRzRT?=
 =?utf-8?B?ZWJkT3ZQZllCak5CL0NZTnlyMGx1OUs3cFZOT1RIOExZVWFQc1VtNDFqRldr?=
 =?utf-8?B?T1E3eEdZOEN6THhCVjl1VHFCRlA4WVJadGhDT0x4L3BnSCtXRlVvZXdpMXE2?=
 =?utf-8?B?ZHBWdWN1MVpuNGxwNXZhd05JeHNvNWdrOXpMTkVsZlJoeTllMFhnQS9ycDRw?=
 =?utf-8?B?YWRZSVlzdFNyMjFyODdoUkxQVU1jOXJwU2VmMm04bGxpMFBEV2ZjbjViaHQr?=
 =?utf-8?Q?igZGGetheQxZ0XZnxVLVIq/cN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63149a23-e57e-4cb9-3a2e-08ddfbb456e8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:50:13.0848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pXY+LAnX7B8PLLQ0Vk5aw2jjoTww+tPg4EvCN+bfJ7Fi1/ryV8OFSI44jGOqgSW8xsArWIpogxfQ2UPlwaeJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746
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

On 2025-09-23 03:26, Zhu Lingshan wrote:
> The user space program pass down a pid to kfd
> through set_debug_trap ioctl, which can help
> find the corresponding user space program and
> its mm struct.
>
> However, these information is insufficient to
> locate a specific kfd process among the
> multiple kfd_process that belong to the
> same user space program.
>
> For correctness and backward compatibilities,
> this commit only allow set_debut_trap ioctl
> work for a user space program which does not
> own any secondary kfd_process.

What happens if a secondary context is created after the debugger 
attaches to a process?

It may be simpler and more consistent to allow debugging of the primary 
context, even if secondary contexts exist. Just ignore any secondary 
contexts for the purpose of the debug API.

Regards,
   Felix


>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 29 ++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 662b181f1fd2..2df095e25c2e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -36,6 +36,7 @@
>   #include <linux/ptrace.h>
>   #include <linux/dma-buf.h>
>   #include <linux/processor.h>
> +#include <linux/fdtable.h>
>   #include "kfd_priv.h"
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_svm.h"
> @@ -2918,6 +2919,25 @@ static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, v
>   	return r;
>   }
>   
> +static int kfd_process_count_cb(const void *num, struct file *filep, unsigned int n)
> +{
> +	u16 *ret = (u16 *)num;
> +
> +	if (filep->f_op == &kfd_fops)
> +		(*ret)++;
> +
> +	return 0;
> +}
> +
> +static u16 kfd_process_count(struct task_struct *thread)
> +{
> +	u16 count = 0;
> +
> +	iterate_fd(thread->files, 0, kfd_process_count_cb, (const void *)&count);
> +
> +	return count;
> +}
> +
>   static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	struct kfd_ioctl_dbg_trap_args *args = data;
> @@ -2927,6 +2947,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	struct kfd_process *target = NULL;
>   	struct kfd_process_device *pdd = NULL;
>   	int r = 0;
> +	u16 process_count = 0;
>   
>   	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>   		pr_err("Debugging does not support sched_policy %i", sched_policy);
> @@ -2984,6 +3005,14 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	if (r)
>   		goto out;
>   
> +	process_count = kfd_process_count(thread);
> +	/* The user space program has secondary contexts */
> +	if (process_count > 1) {
> +		pr_err("Detect multiple kfd_process owned by PID %i, please consider close any secondary kfd_process and try again\n", args->pid);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
>   	mutex_lock(&target->mutex);
>   
>   	if (args->op != KFD_IOC_DBG_TRAP_ENABLE && !target->debug_trap_enabled) {
