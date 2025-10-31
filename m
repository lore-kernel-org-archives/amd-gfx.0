Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBBECCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 02:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8749410EAA3;
	Fri, 31 Oct 2025 02:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3CN90Zp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA95E10EAA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 02:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbX9va8YJZxBQ2CinNubGWdKbfJr1WIcy7BBfWG+FzDsaWuBdvI8vVshp43TK/bYJb2BEFyPG7yhX3C+xyjjxiIpwl58zcvlkQgaccy54428RKQWlkskIACY/DUA/xQlRQaFw5L283X1BMd8yINUdLXwAkr4+ytSXzZAl9P9A7ZoletzhFOZ3qxoYlT/iocdc4GA0tOhyrCbcAjVHHHjCXMGWkVQQUpFMMThCQpvapSZIDIa6vwUmvQFO6tob6JiOvQG+aq81HPFTVCE5rKBqAIbJxa8sr632vN8iwVVq2JwL8M9QwVNNvk3VLTFaz+tgZb/RfHiWLLKf2dIKhb+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFrvjwNbpzaSrCmMx7sbp9pu39LwXqIYrlrQlHUJ4Wg=;
 b=b+baQsTtfYWyt4D2o4czqUuesmTMbtHuTSG18Y+OWKrtPXZWsuxsUZ7tdb1P6L3IoXah+s2gs0aydUkpuowGx2HRiobxEUq7gQGN/f6OqUcX0FOxvPT01+xKtm7+Jq1TIq39dxrgPMBY3m7m+zJSUu2DbNhhy4caBsVODg2jGufFGEwnMXsBXHVDqmQgllJiIO28CdlniXyPcxqwcuOuMG6SS8gom+bNWnKqKPxxB1WaqcW0rtH7OihdGaYFKR4hyveJfSwZ0IAGkkLARE3kwc6dHCO+3caxloNg3TptdDvMqI4iOY1Xcz5Hhhxzqugbhm3/y5tj3R+3O2N/PEG/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFrvjwNbpzaSrCmMx7sbp9pu39LwXqIYrlrQlHUJ4Wg=;
 b=v3CN90ZphW4ceL7rDev5a5xg+0pnKlqkcX71OwbBqCNlu4TCkn3oD1Ib6vTmvpo1J09hrCl0lSuTI1g+C5Rm1l+mnExdDIZmG11lS5zbNQDAPxeBzyT1sMuBvfOWEIh6uGg0aYmFd4yen0vlej/ytf+KFA/6+9H4JZKwmI2NwRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 02:48:14 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 02:48:13 +0000
Content-Type: multipart/alternative;
 boundary="------------CWCQY0VHsmxu4FdUBDZB7jnv"
Message-ID: <89b6057a-ff21-46a2-951b-b96888f60b3d@amd.com>
Date: Fri, 31 Oct 2025 10:48:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, felix.kuehling@amd.com,
 alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
 <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 842ef8ad-67ef-4183-2130-08de1827ef84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWUyQVg1ZjJibnBROVBINjVjSitDRG1sVUNicEY1K1VzWU1jaW5VNXUwcWdo?=
 =?utf-8?B?a2gwN2VZQ0hSWmlJaFZ1V002SmNuZEtYam5Wa0tpSHhVbWRleTNxNjR5akdG?=
 =?utf-8?B?VFF1OC83ZGYvQUEyY0REZWpMZjVVWDFQaDhMNytHc0ZNQ2xtd3BMWmwxclFZ?=
 =?utf-8?B?N2hnVjJSMTZVMTlYTyt5ZS9hZXNpZGFGYjFhU0d3ZG1ISEJGUGhYV1ZqWVZ1?=
 =?utf-8?B?LzhFbmgxNGJRd0JSQzE0V1RVTzBPcXBlMS9TUURHZ1RhdXRhaUQzeDZXNWZo?=
 =?utf-8?B?MHlwSGJaNzhDaVcxQm5iaExYWWxqOUVjY3RpWERqWDFpcG9tSVc2b2EzOXFI?=
 =?utf-8?B?OWg0R2NDVlhEaWxrVFdaQnpPelBhNlZYTitVMU00QzJSR3ZKcGFiR1lnNnU2?=
 =?utf-8?B?MDBNMlhrLzZCMDcrN0d1a0M3R29BNjV5SW9BaHB3ekpnRTRwelFrVWs4eXlG?=
 =?utf-8?B?QUo1SzFxR2pUQlc0czdGaWg3QVNFS1ArUGtEa0pnb0Z4eHJFUUhNRThQM2M1?=
 =?utf-8?B?UmlZZnA4aFpVMWtGT00vVkliS0J2TXg0R2h3Slp3VTB5R09mL2dCVnN2REFP?=
 =?utf-8?B?MjJWVnlQVWJxcEhvNWpUeDhxWGRaekdqZDFCZ0IvV2ZHU3d2OTFmWjV0M1NV?=
 =?utf-8?B?T2I4OG9BTVA2aldFdlNpa2NmcUlKQlBrcVVxaXVxNm9tZWV6RkFiekt5UUFR?=
 =?utf-8?B?ZWx1N0F4dm5rS2UxOXNSNGxzb3lINVYxdHpBRE9nYndQQ2lZTmlLZ29DUXc0?=
 =?utf-8?B?aldRS3FiSHlkNVA1ZU5iT1BOamVZbE94MzhBQ21CSUZRTGZnSi9ZeTBYSkNL?=
 =?utf-8?B?c3liblAyT1BEbkZRME5MejZyano4dWd3ZjJJelNIQXJzUG1RM3l4VHpvaE50?=
 =?utf-8?B?RDZ1YThKbVp1NFlvMmZOOHRvVHpMdnJ0bnRxaHFBazA3UktpNURMdVJpUWpl?=
 =?utf-8?B?RmtoeWgrVUZsRElheGFRYnFkNFA5Rk5rdTJtRXBXZmRnK3VhVmd1RHBKN0Zs?=
 =?utf-8?B?bEhLT1Z5cXp1Nnd5TWZXclhKcHhsQjUrLyt6bHBKVFNVcEozeHQvL211WWN1?=
 =?utf-8?B?TzFuRDZGV1ZSVmRUUUVvY2ZDMlg3aGs3VkxpWUpUa3ZFMzRqc0Y1cU4veTVJ?=
 =?utf-8?B?MmE4MXMwMDlZWWZSZnBKSXkzT0ZTWXJ3V1BoeTNWRGR4VWVHYlRwK2xWWFE1?=
 =?utf-8?B?cUk5b0JjMGVDcE5MYmh6ZjZPWjZCZGhrRDByMktEdkhULzZrMElvNi92LzRs?=
 =?utf-8?B?LzdrM1hUQlVZUTVBazhLS0ZyNGdhTW50Uk5uK2ZCWjdRNnlISUhGV0ZrOHEw?=
 =?utf-8?B?WlBnZUNxQnk1aUp2T01OSGpmK1VOY0thRTFmRUJHcEZ0ZFY4ZDlMa0FzVUo4?=
 =?utf-8?B?V20rS2lGeGx4NjdhVGtEUWRpYnZJdnpFWDZqdzNlaTZLdnJlOGI1aUxQYWo0?=
 =?utf-8?B?ZFdGNkpUQ0cwRmFSWUR2QzZRaDl5YXR6S2J0OHdybzA3NmJIQnc2aEZ3dC9v?=
 =?utf-8?B?b0wyMDcrSmQySmwvZGR0VmNiV3gwcnhPdmE5eWlzRVJlY1cvYnBDTXRzdHl3?=
 =?utf-8?B?d3U2QW1QQnVLWEtEemlvOWcyaFMwK1VhWE1SVERWakVEMWg4RWpuOW40ckRk?=
 =?utf-8?B?anZJQUJndTlYbWJDUUtzdG5LaW5WajBaNDR0NGxUbU9JUE5vb2plOU0xYVh3?=
 =?utf-8?B?QWNqeXVxM2VHVnkzdXhocTdDQ1RUckg4bi9YR0xMVGp5eXZNbTRIWEVMdDJn?=
 =?utf-8?B?NjZSY3JuVmM5b2ljQjV4QjA5NVZOaWpOblJEaXBPWWlxMFNaeEg4MDU1T2VC?=
 =?utf-8?B?OW9zakRJZUFxLzA0eGhSZWMrNjU0Vy9wd0h3SnN4V1puOVY3Z0VJMVVlZytT?=
 =?utf-8?B?UnFaK0JrTitrSFVydXdwM0Y3ZDM4dGlqUEw0YlB0elFUQmE3NStrSkp3bGdU?=
 =?utf-8?Q?OEjzBGoYm0sM2wgK+O9Pj6yEK0dkxxsG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVzZlVLS3Rnb0pQQkR3QXVNM1E1ZGRhTzkxMEN0RnVDSVZjQlRGMlFXYW5Z?=
 =?utf-8?B?S1BveWFBN2p3S2NsN1QzMlBhQkJ1b1NZQW9QaVRwQ3R6WW5uZ1NuelB4NFdr?=
 =?utf-8?B?Ukhrck05L1ZFQjBzYXlVV0VIa0xmVUdpUDNhU1V4Vm4ralI4TnNvM3N0Tysr?=
 =?utf-8?B?bUFjSVFMYTlwRWhVK2NHUjBOaVlRUGZYZDJoR1lzNUpXOTF3ZmxNd0tGNVZw?=
 =?utf-8?B?clJEdHBLejZxVjNFbnUxU2hoWVV4MGNxSllyYnhsTDNuckVoRk55ZFV5VzRr?=
 =?utf-8?B?b2pybXRGMlpJWWtWYm5NWFU3RXVFeXZJWmhrSVcyczdMN3J2eDdJR1VhU1VV?=
 =?utf-8?B?SndsRmRXaW55VGFWclNYMFVQNHVIVmJjdTA1VnhHb21SNzUxWkk1RGlKSVpn?=
 =?utf-8?B?dUx1eWExUExtWkI2V1V2ZXp3UmQrazVFMG1pRDB0Z2xseDBQMUZpK0lMY2J1?=
 =?utf-8?B?NHgxcUdXdzdhSjdNUkQ4MDRtM0kzYVZZbk96YUJpWE1EZldRZHhRbUUrUFJn?=
 =?utf-8?B?NnJIMXFucXdMRnIrVkY0OXZIZGZNYmpvV3NQaEVpYURpZ01MK2ZoOWdLOEYx?=
 =?utf-8?B?Q3BPelQ1eW1qdFR0MytpbW12eEZjS2VpUWk3V2JwSkRwNFdFMmtxNmdhdW5s?=
 =?utf-8?B?NGZWOW5xbzRWVS9HSzZrNTNGakl5RHYvRWI3cUc3MlY3L09DNlg0eEZtWk1Y?=
 =?utf-8?B?dGc4OGtrNi9jRzVyM3I3RDNnN0Z2NXp6a1hSb3RkVk5kS1B2WFlsNjRmdGQx?=
 =?utf-8?B?Y3d3Ym1ucVVHczhrdzZnZHF6R1E2bmlVdTNINVM4ejM3c0JVYVNVbDJObHdK?=
 =?utf-8?B?T2pnZFZuaXJYOWQycFpCWHh3QVhtak1pQi9DNk1xNE5zd1IxUUdXV0dCOEJL?=
 =?utf-8?B?cTUyZWxxWWx2alRsb2VDcEU1bTA5bkhJb0tHOVExWXZkRmhCMnE1YWUyNGZH?=
 =?utf-8?B?MFVFREhXZlNmWFFtM2prTmpPUE5jODV3RkdYNkVZRGhvRkV2aFkzNUkzVjIx?=
 =?utf-8?B?cUZwcGlrM2ZUZWZMTmh4bitoT0VHN2tKUGpCMWRLNVF3dlVrcUVFdkdPRFpQ?=
 =?utf-8?B?NEt6KzRjWTBic2xpNXlFM0Q1SllJcXdHaTdNYkRTalVDalZsbHdSMTBLRlpX?=
 =?utf-8?B?L2ZjeUxVNW5rNmFsM1RPK21Oamc0MU16VzNQbFZEMjhSWHB4ZkFXcXpYZDBk?=
 =?utf-8?B?Nmo2WHY4L2wzYkM2VmJpRHBvRGIxN3JzbGlOTTg0UEpKZUpXcW41RkZ5azdD?=
 =?utf-8?B?cWpmaUJLK0VSRTlKYVJXUVNFTUdJRWNZTkJsYlhwSi9hTWllOGRkRWhwU0lT?=
 =?utf-8?B?engvQWV4Ykd0LzFQaUd2cU5Hb3ZpVUVUWlFiNmhBNytOQkxtcHBiNWZYV0tE?=
 =?utf-8?B?bnkrT3VJVy9DTEZJYjJwMVdjczEra2JSQmVCQ2MvbHRmbFl3V1Fsai9DU204?=
 =?utf-8?B?c2JsOXFjLzFlYW5GNUFQU3FwdHZ1ai8wTkJqRVJVQjVXMGxXTlJnaU9HeFp3?=
 =?utf-8?B?UnEwVHREYkZPU0taeFN1UmJwb0NzQ29ITGo2R3lXMGdoc0Y0WVpoWHpseU5k?=
 =?utf-8?B?N2EwMWJBbVVUU0lWRTFoMUJRRGtSSHhDMjhua29yOXFhQk1kOFhia0ZwZjI4?=
 =?utf-8?B?UC9lTXJBR29ETUY3aUQyc010K0h5SVFNZzcwbGVmRlY0dTJ1TDFTRmZMWVZY?=
 =?utf-8?B?b1NrNm5hYXppZ3Y2T1UrM3RZU2JOY0hGWXZHZStqSW5iNUNpMHoyTjRKMFJ5?=
 =?utf-8?B?NFRUTXpmcEJtTHM5MUV6S1FBUEJvN3FHWjF1VlMyT0pRNmg0aWJDZFFXOHc5?=
 =?utf-8?B?T25DSXVkVUhwaXMrSmhpM0c4OUNVejJmR3E4eDZBOWNRWmI1WS9SWi9waW5x?=
 =?utf-8?B?UXRSdHd2UE5CS2dVcVRYZEpFOXg4Rmlha3NDNVMrU0dTVTYwbFI4dWpZRXRz?=
 =?utf-8?B?MDVEL1FleEFRSlJ0S3ExSGdYOU9aUlhjL0tIN1ZqbE5UMWw5K2JGSmNWUFd6?=
 =?utf-8?B?cjljL2pxVVdjLzhTWHFudHRGV0NHUzdYSldqWlZGYUZHRjJ6dG1rdUlTTDBL?=
 =?utf-8?B?OThrVVRLT1FRVE9CdkJnVTM1MkJoYjJrWDhKcFg2Y2dFcHUvRFZ1SmFmWG9k?=
 =?utf-8?Q?2h48eyo7BOGZOXkRbOdCvOvsb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842ef8ad-67ef-4183-2130-08de1827ef84
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:48:13.6080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xegwyx4iWxZXZtM/hczWxbIC23/w5Mu3Z0vhRKzzQBRyHs7SZCc5m5gjsvMVHXBrbHHyLO0242D0XdGIQ3JnOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

--------------CWCQY0VHsmxu4FdUBDZB7jnv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/2025 11:53 PM, Chen, Xiaogang wrote:

>
> On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
>> The pasid is a per-process-per-device attribute,
>> therefore this commit implements per
>> struct kfd_process_device->pasid in sysfs
> This per device pasid is used internally in kfd, not used at user
> space. So no need to exposing it. 

current sysfs implementation exposing PASID to user space, but buggy value 0, this commit
intends to fix this issue.

Thanks
Lingshan

>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>>   2 files changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 70ef051511bb..6a3cfeccacd8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -864,6 +864,8 @@ struct kfd_process_device {
>>       bool has_reset_queue;
>>         u32 pasid;
>> +    char pasid_filename[MAX_SYSFS_FILENAME_LEN];
>> +    struct attribute attr_pasid;
>>   };
>>     #define qpd_to_pdd(x) container_of(x, struct kfd_process_device,
>> qpd)
>> @@ -983,7 +985,6 @@ struct kfd_process {
>>       /* Kobj for our procfs */
>>       struct kobject *kobj;
>>       struct kobject *kobj_queues;
>> -    struct attribute attr_pasid;
> We keep it to have use space tools(ex rocm-smi) work as the tools
> still read it before they change.
>>         /* Keep track cwsr init */
>>       bool has_cwsr;
>> @@ -1100,12 +1101,6 @@ void
>> kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>                       int handle);
>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>   -/* PASIDs */
>> -int kfd_pasid_init(void);
>> -void kfd_pasid_exit(void);
>> -u32 kfd_pasid_alloc(void);
>> -void kfd_pasid_free(u32 pasid);
> This part is right, these declarations were forgotten to remove.
>> -
>>   /* Doorbells */
>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ddfe30c13e9d..24cf3b250b37 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute
>> *attr, char *buffer)
>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct
>> attribute *attr,
>>                      char *buffer)
>>   {
>> -    if (strcmp(attr->name, "pasid") == 0)
>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
>
> Same as above we keep it to have compatibility with current tools.
>
>  Regards
>
> Xiaogang
>
>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>> +    if (strncmp(attr->name, "pasid_", 6) == 0) {
>> +        struct kfd_process_device *pdd = container_of(attr, struct
>> kfd_process_device,
>> +                                  attr_pasid);
>> +        return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
>> +    } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>           struct kfd_process_device *pdd = container_of(attr, struct
>> kfd_process_device,
>>                                     attr_vram);
>>           return snprintf(buffer, PAGE_SIZE, "%llu\n",
>> atomic64_read(&pdd->vram_usage));
>> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct
>> kfd_process *p)
>>        * Create sysfs files for each GPU:
>>        * - proc/<pid>/vram_<gpuid>
>>        * - proc/<pid>/sdma_<gpuid>
>> +     * - proc/<pid>/pasid_<gpuid>
>>        */
>>       for (i = 0; i < p->n_pdds; i++) {
>>           struct kfd_process_device *pdd = p->pdds[i];
>> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct
>> kfd_process *p)
>>                pdd->dev->id);
>>           kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>>                           pdd->sdma_filename);
>> +
>> +        snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN,
>> "pasid_%u",
>> +             pdd->dev->id);
>> +        kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid,
>> pdd->pasid_filename);
>>       }
>>   }
>>   @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct
>> task_struct *thread)
>>               goto out;
>>           }
>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>> -                      "pasid");
>> -
>>           process->kobj_queues = kobject_create_and_add("queues",
>>                               process->kobj);
>>           if (!process->kobj_queues)
>> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct
>> kfd_process *p)
>>       if (!p->kobj)
>>           return;
>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>       kobject_del(p->kobj_queues);
>>       kobject_put(p->kobj_queues);
>>       p->kobj_queues = NULL;
>> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct
>> kfd_process *p)
>>             sysfs_remove_file(p->kobj, &pdd->attr_vram);
>>           sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>> +        sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>>             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>>           if (pdd->dev->kfd2kgd->get_cu_occupancy)
--------------CWCQY0VHsmxu4FdUBDZB7jnv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 10/30/2025 11:53 PM, Chen, Xiaogang wrote:</pre>
    <blockquote type="cite" cite="mid:050ba477-c7d5-4420-8f06-6fce0db48726@amd.com">
      <br>
      On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">The pasid is a per-process-per-device
        attribute,
        <br>
        therefore this commit implements per
        <br>
        struct kfd_process_device-&gt;pasid in sysfs
        <br>
      </blockquote>
      This per device pasid is used internally in kfd, not used at user
      space. So no need to exposing it.&nbsp;<br>
    </blockquote>
    <pre>current sysfs implementation exposing PASID to user space, but buggy value 0, this commit
intends to fix this issue.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:050ba477-c7d5-4420-8f06-6fce0db48726@amd.com">
      <blockquote type="cite">
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++-------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18
        +++++++++++-------
        <br>
        &nbsp; 2 files changed, 13 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 70ef051511bb..6a3cfeccacd8 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -864,6 +864,8 @@ struct kfd_process_device {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid;
        <br>
        +&nbsp;&nbsp;&nbsp; char pasid_filename[MAX_SYSFS_FILENAME_LEN];
        <br>
        +&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define qpd_to_pdd(x) container_of(x, struct
        kfd_process_device, qpd)
        <br>
        @@ -983,7 +985,6 @@ struct kfd_process {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Kobj for our procfs */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queues;
        <br>
        -&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
        <br>
      </blockquote>
      We keep it to have use space tools(ex rocm-smi) work as the tools
      still read it before they change.
      <br>
      <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keep track cwsr init */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_cwsr;
        <br>
        @@ -1100,12 +1101,6 @@ void
        kfd_process_device_remove_obj_handle(struct kfd_process_device
        *pdd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int handle);
        <br>
        &nbsp; struct kfd_process *kfd_lookup_process_by_pid(struct pid
        *pid);
        <br>
        &nbsp; -/* PASIDs */
        <br>
        -int kfd_pasid_init(void);
        <br>
        -void kfd_pasid_exit(void);
        <br>
        -u32 kfd_pasid_alloc(void);
        <br>
        -void kfd_pasid_free(u32 pasid);
        <br>
      </blockquote>
      This part is right, these declarations were forgotten to remove.
      <br>
      <blockquote type="cite">-
        <br>
        &nbsp; /* Doorbells */
        <br>
        &nbsp; size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
        <br>
        &nbsp; int kfd_doorbell_init(struct kfd_dev *kfd);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index ddfe30c13e9d..24cf3b250b37 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct
        attribute *attr, char *buffer)
        <br>
        &nbsp; static ssize_t kfd_procfs_show(struct kobject *kobj, struct
        attribute *attr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buffer)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; if (strcmp(attr-&gt;name, &quot;pasid&quot;) == 0)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%d\n&quot;, 0);
        <br>
      </blockquote>
      <br>
      Same as above we keep it to have compatibility with current tools.
      <br>
      <br>
      &nbsp;Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">-&nbsp;&nbsp;&nbsp; else if (strncmp(attr-&gt;name,
        &quot;vram_&quot;, 5) == 0) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (strncmp(attr-&gt;name, &quot;pasid_&quot;, 6) == 0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_pasid);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%u\n&quot;,
        pdd-&gt;pasid);
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
        atomic64_read(&amp;pdd-&gt;vram_usage));
        <br>
        @@ -662,6 +664,7 @@ static void
        kfd_procfs_add_sysfs_files(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create sysfs files for each GPU:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/vram_&lt;gpuid&gt;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/sdma_&lt;gpuid&gt;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/pasid_&lt;gpuid&gt;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i];
        <br>
        @@ -675,6 +678,10 @@ static void
        kfd_procfs_add_sysfs_files(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
        &amp;pdd-&gt;attr_sdma,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;sdma_filename);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pdd-&gt;pasid_filename,
        MAX_SYSFS_FILENAME_LEN, &quot;pasid_%u&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
        &amp;pdd-&gt;attr_pasid, pdd-&gt;pasid_filename);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -888,9 +895,6 @@ struct kfd_process
        *kfd_create_process(struct task_struct *thread)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(process-&gt;kobj,
        &amp;process-&gt;attr_pasid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pasid&quot;);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj_queues =
        kobject_create_and_add(&quot;queues&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process-&gt;kobj_queues)
        <br>
        @@ -1104,7 +1108,6 @@ static void
        kfd_process_remove_sysfs(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;kobj)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;p-&gt;attr_pasid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_del(p-&gt;kobj_queues);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(p-&gt;kobj_queues);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;kobj_queues = NULL;
        <br>
        @@ -1114,6 +1117,7 @@ static void
        kfd_process_remove_sysfs(struct kfd_process *p)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
        &amp;pdd-&gt;attr_vram);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_sdma);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_pasid);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(pdd-&gt;kobj_stats,
        &amp;pdd-&gt;attr_evict);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd2kgd-&gt;get_cu_occupancy)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------CWCQY0VHsmxu4FdUBDZB7jnv--
