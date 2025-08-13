Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1ABC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 20:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0924410E7D5;
	Wed, 13 Aug 2025 20:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4gd2U9u";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC9E10E7C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 20:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHrlUB8gLo4ZtHR6x6I8earh6YCn1INTq5d6ZI7fL3HizVgh9KrJanl0DAfgoCAErq4TQfCkkkeWFPmDpKvytE0Ymxnolg0Mg1HP5e4rAJWuTdRN7lbDTAT08afMiuoBJMGit8AQTWcpKuaJI/mUI+uGy1+9M69DIrF+nVVdeDQ+qgrUI4E2iM0nQ3dEsTUoTqh15akDvWQyYI5JmeX7DWA5BLmzmrFZ4zguqXGf1AP67KhZoiVxhCd1o9cu1lwsIE5UUkYgU2+JoWPHBUtO8RScZ0jsfwFk/cufmm6n6lO90YSL8vlWCb0jhMigyEifhavEr8GHVIkVoT4MimGapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiQw9xEnJmil8VK2rZiVrESCvmrq3HJtqOXjcyH+euc=;
 b=lQx3U9Vh/TI8fxsq4zePwd/HHNk46PpqQrwmTkvfCrtFGSreUDRzGfOWtpj6M8OAVyDycAaFKJ/Tq7L6YRQlHy2M0u22fQjY1nAJuyDnS0aC9Ucitg5W3UHc8dY56BXLxwuCrHy/CLCQUx5wnWheR/Iu9MF4LTtjQ+ScEJjO0bouUOEi6T0QIPcMoIGXGnk0qty0pvRzZ25AP1Ef5HDxKyVC/ggNtWySoRncs8iT9cD3gOGTXHwLxc/sdybx9b9Z9Z5+5fIU8vbmnVjbro7kW0Sgov0WEXN75uYwCnAKbGj+Nw+1F54ihy5CTnPkACb3cwN/xQWZOmSjcO7wwWYdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiQw9xEnJmil8VK2rZiVrESCvmrq3HJtqOXjcyH+euc=;
 b=Z4gd2U9uhD2KBlsM/Rg4VVw5T9fEKzIHvOoyhpe+aZZDHZwHwROaRZehNkp4P0o28Fr623uEwI6/Qw1EyPL9bvLFAZw8WCmVioqR82vwK2lgeT46oOc4HJhi/rFxL0Yuw/ozvhewRD59w/Bw8EmQGET+7ZCHpNFiJKB1M+YNAqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 20:58:06 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 20:58:06 +0000
Message-ID: <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
Date: Thu, 14 Aug 2025 02:28:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::16) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2496c7-adca-468c-bb50-08dddaac1a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akxNRjhMZmVjL0NKVFhiWElEZFJ2K1NZTWtXRmY5ZjZsejhPQTJjbGlZeURz?=
 =?utf-8?B?aWlNMS9QVGZ2R2JwUmZ3ZFc3c205ODd5UlVKVjV0UkVtVzhvS3hLZnRLMmRh?=
 =?utf-8?B?Z0VHbjBzekZONUNFR0s5V2IySEVZako3T0V2SVg4ZkZsanU4T0VVUHl1dU9W?=
 =?utf-8?B?MG1jQVI3VjFreElUQ3ArajFTREFvbE9GSFJSbkx3bUF1aTRQZHZRT2R5cENP?=
 =?utf-8?B?U3Z4VmdMcm13L2lwUTlnK1ZEUHR0dGVkRXpkU1hBbUNtcXhoTmVTa1FiZlNi?=
 =?utf-8?B?TE1NclROaER6Uzhtd005cTgremJ1U2o4NENUZERiN1U4QXFMSlpobnJQQS8y?=
 =?utf-8?B?RVcvcUxSVUtySkxnNmNWTjhodThYQWV4NkdSbklFNHVobVd4cDc0eU1lczFF?=
 =?utf-8?B?b0pCL29ldXZWeWVIei9pWS9kYjlMRzFBQTFNcmtKOHg2NlZJQlZ3dEt3aVVI?=
 =?utf-8?B?SGRYNHIySk53ZGdvdjgvenhyY09pa1QyK0dMRnFBK01Bbk1abGtTS0FoUmxF?=
 =?utf-8?B?UnFIZ1dhS0c4cnZGNnpKUVdZU0lhekdUVmdqVSt3QWNudzI4cEMxdE5RakFU?=
 =?utf-8?B?cjIvdk9wYXlNeUN4ZmNFQlgrN1FuajFvcVAyRm5yaHRuaHdZTlE2QnFoRXhW?=
 =?utf-8?B?MXp2WkNJeWpybjkzR2RVd1VtMmFiQW5ramxzbE1DUi9GWjV6aVY2UmtrcEN5?=
 =?utf-8?B?TlpuMWVJQWRtUDNpdEtrck9JV2o3SFhZNi90dWh3ZDBIL1pPRDJ6TlUvQ1R4?=
 =?utf-8?B?RzViQVVmSWs4aHlseU41YkJBY21xdi96YlFwQlJtTVovSmR3Mmw1SHA5dElG?=
 =?utf-8?B?ZWtnWFFEVm50ajZ3aTBEVUtWMXV2NmhMN2lBWTFldGU0WlIrd1c2Nm16UDF4?=
 =?utf-8?B?M2tKWGFua2Y2bEFLZStqZFRURGdaVXBZcHphdWQ3Tm5nZzNTd3RGTE5lT1Iz?=
 =?utf-8?B?QTRzNllLbXNQb2tZdC8zRVduTEliZC9wZ05RSHI5ZlRxOEY5ZFc5ZzBCZjBO?=
 =?utf-8?B?ZVJ0c1d3ampFSUVpZDQxYkthWHROWmlNTzY1SUlxQUdKdUUvSXlyTHBiZnU0?=
 =?utf-8?B?YnFSVTA1Z2Y4SVp1c2JXa2pKb21iYWpHdTQxVGI5YlpjS1d6Zkl0NHpDUVFh?=
 =?utf-8?B?R0QzTXV2ZnJ1VTgxeUtWSTF4b1czMng0Y2JIM2J3SjBaQUJ3MC96UTZPeStR?=
 =?utf-8?B?LysrWnlhZC9oMU9mTEZvTE1yTmFkeUJFUFJqMlhxRnYxcDYreHpZTUhaNjIw?=
 =?utf-8?B?WndFMFYxYVFYRmdha09QbDI2VmRnTWhtY3JpRmQ5Ukh4NHRnN0NOaitqWHhp?=
 =?utf-8?B?TTdVdkZRUk95S3JzTG9LMXpHdjhjbUM4RzN2ajl1aURLK2I3UnFheXJiTFl1?=
 =?utf-8?B?WGl5LzI5MlVuUzlNeEllcDNjR3BacWc0LzFNR1FUbkFnZEljUlBNeERIdVUx?=
 =?utf-8?B?VEZlUTFWdTNjWklFZXp0VnVNbUV3Q2YzOG1QazZvMUhLOTFKL3l1SE95cHZN?=
 =?utf-8?B?bHZiTHZWayt4aVpwQ0NJVlZxZDFvRERHeE9SdDRteFk3blFjeDhyYkZPRjR2?=
 =?utf-8?B?bE1tcXlhSGhtbWNOSkR2VElSazRKQXUrWnRDZkFBaTJkSUNPdThxRDVkT1RP?=
 =?utf-8?B?MVQrN0JsOGxBOWwwNUllMmtUL3E3UWtjdWpJLzZkYXM4MmUzcDAvMWdvSGhq?=
 =?utf-8?B?OWkxWlRNVzU5aGJDQTFHdVlJZ09SdnFmUWZVMVlwUjNQMXJnbHF5VWNJL2pI?=
 =?utf-8?B?S0psNUZGa2RvRWFBNEk2b005dFZ3Tzk0Z0o4WWV6RVhTUjVXMFozalRLMnpT?=
 =?utf-8?B?bE1jeFdwaENJRXJpY1NEZit2V2VXVW51Z1MxOXh2b3hwMm8rcU45L2pua3RH?=
 =?utf-8?B?VUNsZlhWM2YxTmJaOUV0WTVjMDZlZVZvZGo3YWd5WDJoUkxVWmh6eU5MUDc3?=
 =?utf-8?Q?sy3Sa+7jQGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9wdDlhaUNleVRGQjgwNi83WmN1cWd3aTlId2RmMlFlbU4zay9ZcUtzL1pa?=
 =?utf-8?B?eHV5Y3ZGRHZKQm5nZ2ZMelY5S1Ivam9rbWUwZDJPZGpEam1iY2JaUUFxWGx3?=
 =?utf-8?B?UFVGdER5aDBqZER3dVI1M2RtT2h4bXNoeG9oS2kzNlVycGI5VHhja1lyN0Zm?=
 =?utf-8?B?RFhKbklJczEvMkZtOWFQbUxBdVEzK0hjSzdOYWtleVJ0bzRSb1Rublh1L0cy?=
 =?utf-8?B?NkFaeVlvOGpucCsrVWlMeVZPRklFRWdLTFhnMVhQVlJOUmNXOXhOamU3cWxz?=
 =?utf-8?B?dXhTd2hrSzN4c1IxaHRxY3N4RHhLdFBpSFZYa28wWGhCY2NBVHM5eERJNmNx?=
 =?utf-8?B?bnFIZXppSkswTXErRmJLQkRodWJaMmNOUStwb3B1YTJwdUwvOHR4L095WDhE?=
 =?utf-8?B?UTJzT1E4d2FMbEo2RVVReXd4WWg0dXpYdWJ1YjJSeFZndFNlTUlFLzlZRzB1?=
 =?utf-8?B?M1RDVmRRWjc3QVdSQjY4dnpGckZUTHpQUWZPY25lYThNbzBDS2xON1FuNllt?=
 =?utf-8?B?UkVDZ2FxcjlIMVloRjBwaFZ5WVE5Q2xYa3ZFNHA2VGx3S0xySGx0MFRFTE9F?=
 =?utf-8?B?bTd5eEt0VEEvQXlMNWU4QUtLdUcwcmdCRTV6b3lPTU9GZmw3SUVwaFc0ek9y?=
 =?utf-8?B?dFdod0NNemZ1NXpiSlBnYUhydXJBclhpeTdxTUgwRUtNOVpqd1p5QitxSHlk?=
 =?utf-8?B?YzIwbU44TXBUckk0K3BKSzJPUllyK1I3UG5rczFNbFZ1bDNUZXc0ZS8yUXRT?=
 =?utf-8?B?WHdGa2JjZFFDQU5MSElvSk1EQzZ4MlVWaXU5WXY0VjJ3Z0tJSlJZUVFYTE15?=
 =?utf-8?B?TzBEem0zZjd3RlVmbW14OU9SQWtUWWwrS1l1L3ZkL2JGY1QwZnl6dGpQNE5l?=
 =?utf-8?B?L01rakQ5TVQ0bmh2OWdtdXlQbnpobncrV21QUGdqNDByMlpwU2dJTE4rZ3ZQ?=
 =?utf-8?B?TVB5Z3VuVXdJZVVrWVR6TW04QWQ5K3dWekNTaGg3SmIvZzNHMGNEUGFZQllV?=
 =?utf-8?B?T3Bwb0UreVY3d2tNallZWHA2SU5SMXRlRkRJSHVUZGZTRDg1SlI0WStQak8z?=
 =?utf-8?B?eHBhbzRreVFSWDYybWNwdWorY2JpMmlwSmVYWElFZUgyckxpQ29Bbms3dk1s?=
 =?utf-8?B?YnFyV2pnbkJzUEtteGxjSkZoYlV5NS9ZcEUrNE5Ub2RYbkpuOHprdzlWNVdw?=
 =?utf-8?B?TG93RW9sVXk4V3ZiNVpITnBTWWVqYy8yeVQvcEdpSWtaUC90dHdsZTVncDd4?=
 =?utf-8?B?ajNGTm9CdW5sdk16eGd3bWQ1RE1KL3kyancrMUJiVnBOeU5jbmJNbWpxM05t?=
 =?utf-8?B?b1hkQXdwZkFtbVNsbld0RlArUXF0RUszdi82V0UzQzBmK3g2cU10RDVnb1k1?=
 =?utf-8?B?NVZIQUYzbVdHbDlBLzNSM0lYZWtreGpIRnlUVk5oSTNmTzhuZUpuemNOSkls?=
 =?utf-8?B?THpQTmdrSVdKV0VoT2tSNnNPbDNJY2t1VEZsWng0bWZnWDFudzdYVERlK1Zy?=
 =?utf-8?B?UEc2L1I5NVV3cGZyUjRCU1dTdUFpZmhxbnJRNVVFQVNFVGZ6QmVKWGIvT0lC?=
 =?utf-8?B?VEt0NGxuVDdQR1lkUzNaeFhkcEFla05FN0svOVp4d2t0VlA4MXdBakxreDY2?=
 =?utf-8?B?YTFUbHAramRuQ1JZVTNlS0VVVlE0T2kzTXhpVnhUVk1kWWgrd2hGU1kxeVhw?=
 =?utf-8?B?bGFEZ01NVk83cFZvSVExSDZROCtNOGNCZXZLQ01OU2xJVWZ5Nk5XaWlmYmxh?=
 =?utf-8?B?R2Z0dFVxQlZTQk1VWElOVEhkMkRhS0JvMlBFYkR6amppMHFyM1hkdzVVYWRY?=
 =?utf-8?B?K20yTlhhK25hSjYxbjJ3d2pKUjk4eHZxUHdJUDRxMENZdE9kRWQvcWJPcWNJ?=
 =?utf-8?B?YnVJU3RiZEIrWVJ0eEpnemJKOXpTNmNEb2cvdUxXRmVoWjZ6YVJpS2hYeS94?=
 =?utf-8?B?NldGZnlWTHlTakUvK0dLWjM5eXFyTHZ3aElQZ09VY3d4ZG9yRHRxMzJMem9G?=
 =?utf-8?B?SVk2bzY3ckZTU0kzWk14WGxLaXNSTzRHWDBuQ3VqOG5IQmQ3Qk1jVUlqRjVK?=
 =?utf-8?B?cHpsY0ZibVVrbzF3ODRldElUNGJYVTB1V2s0Ny8yd1YzZkd0ZnBZUkJsUWRK?=
 =?utf-8?Q?jSrpmimUS6MkTWhwahSLnJqOQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2496c7-adca-468c-bb50-08dddaac1a10
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 20:58:06.6176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMdJNEyJBefoved5o2QWPzTPi0yOkgd5ECfTDdMIdpqP+DCWxsk9ELjOOtQgi9eVY71dO5crTXTOju2XVVJGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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


On 8/14/2025 1:35 AM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>> Hi Alex, Hi David,
>>
>> I see David's concern but his suggestion yet wont solve the problem,
>> neither the current form , reason :-
>>
>> The emitted fence count and total submission count are fast transients
>> which frequently become 0 in between video decodes (between jobs) even
>> with the atomics and locks there can be a switch of video power profile,
>> in the current form of patch that window is minimized, but still can
>> happen if stress tested. But power state of any instance becoming zero
> Can you explain how this can happen?  I'm not seeing it.
Consider this situation, inst0 and inst1 actively decoding, inst0 decode 
completes, delayed idle work starts.
inst0 idle handler can read 0 total fences and 0 total submission count, 
even if inst1 is actively decoding,
that's between the jobs,
  - as begin_use increaments vcn.total_submission_cnt and end_use 
decreaments vcn.total_submission_cnt that can be 0.
  - if outstanding fences are cleared and no new emitted fence, between 
jobs , can be 0.
  - both of the above conditions do not mean video decode is complete on 
inst1, it is actively decoding.

Whereas if instances are powered off we are sure idle time is past and 
it is powered off, no possible way of
active video decode, when all instances are off we can safely assume no 
active decode and global lock protects
it against new begin_use on any instance. But the only distant concern 
is global common locks w.r.t perf, but we
are already having a global workprofile mutex , so there shouldn't be 
any drop in perf, with just one single
global lock for all instances.

Just sending out a patch with this fix, will leave it to you to decide 
the right method. If you think outstanding total fences
can never be 0 during decode, then your previous version (v3) itself is 
good, there is no real benefit of splitting the handlers as such.

Regards,
Sathish
>
> If it is possible, maybe it would be easier to just split the profile
> and powergating into separate handlers.  The profile one would be
> global and the powergating one would be per instance.  See the
> attached patches.
>
> Alex
>
>> can be a sure shot indication of break in a video decode, the mistake in
>> my patch was using per instance mutex, I should have used a common
>> global mutex, then that covers the situation David is trying to bring out.
>>
>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>> track power state could help us totally avoid this situation.
>>
>> Regards,
>>
>> Sathish
>>
>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>> Hi Alex,
>>>>>
>>>>> The addition of  total_submission_cnt should work - in that
>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>> someone
>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>     - up to you to decide.
>>>>>
>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>
>>>>> Thanks,
>>>>> David
>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>> If there are multiple instances of the VCN running,
>>>>>> we may end up switching the video profile while another
>>>>>> instance is active because we only take into account
>>>>>> the current instance's submissions.  Look at all
>>>>>> outstanding fences for the video profile.
>>>>>>
>>>>>> v2: drop early exit in begin_use()
>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>
>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>> handling")
>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>> ++++++++++++-------------
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>     2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>         struct amdgpu_vcn_inst *vcn_inst =
>>>>>>                 container_of(work, struct amdgpu_vcn_inst,
>>>>>> idle_work.work);
>>>>>>         struct amdgpu_device *adev = vcn_inst->adev;
>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>> +     unsigned int total_fences = 0,
>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>> +     unsigned int i, j;
>>>>>>         int r = 0;
>>>>>>
>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>                 return;
>>>>>>
>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>> -             fence[i] +=
>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>> +
>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>> +                     fence[i] +=
>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>> +             total_fences += fence[i];
>>>>>> +     }
>>>>>>
>>>>>>         /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>> be handled by FW */
>>>>>>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>                 struct dpg_pause_state new_state;
>>>>>>
>>>>>>                 if (fence[i] ||
>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>                 else
>>>>>>                         new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>
>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>         }
>>>>>>
>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>> -     fences += fence[i];
>>>>>> -
>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>> +             /* This is specific to this instance */
>>>>>>                 mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>                 vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>                 mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>> !total_fences &&
>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>                         r = amdgpu_dpm_switch_power_profile(adev,
>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>> false);
>>>>>>                         if (r)
>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>> amdgpu_ring *ring)
>>>>>>         int r = 0;
>>>>>>
>>>>>>         atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>> move this addition down inside the mutex lock
>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>
>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>> -      */
>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>> -             goto pg_lock;
>>>>>> -
>>>>>>         mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>> move to here:
>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>> I think this should work for multiple instances.
>>>> Why does this need to be protected by the mutex?
>>> hmm.. OK - no need and it is actually better before the mutex.
>>> David
>>>> Alex
>>>>
>>>>> David
>>>>>>         if (!adev->vcn.workload_profile_active) {
>>>>>>                 r = amdgpu_dpm_switch_power_profile(adev,
>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>> amdgpu_ring *ring)
>>>>>>         }
>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>
>>>>>> -pg_lock:
>>>>>>         mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>         vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>
>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>> *ring)
>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>
>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>
>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>                               VCN_IDLE_TIMEOUT);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>
>>>>>>         uint16_t inst_mask;
>>>>>>         uint8_t num_inst_per_aid;
>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>
>>>>>>         /* IP reg dump */
>>>>>>         uint32_t                *ip_dump;
