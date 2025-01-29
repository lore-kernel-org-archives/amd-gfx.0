Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525CFC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 16:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018DD10E83C;
	Wed, 29 Jan 2025 16:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hBSvKXO0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E328C10E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 16:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmEHDD7+aTxAE6eUjjnkiw/4XBnLGb/5zk8iCKUYpvfyP/LHBLZc8IQL69COP586NEeH6T9I/QM2boVaVlQqNWm93nh9j60Tajct0AkDt5N0eKNP0lX6nboYd/LdUeC62VBGJ3z8SSThsn+RkLcQyzarhQc03mnMgwLSVqelXKSaVIOhPBtPyYxThygq0XG/sx2bfvkNlvp8SH6Fsguo7qWeLElnLuLd7yu3N/YE696whozputSiKJIoTb0gcMy3Veh9p1Y2v3H7/CH4MnYq0oADmpQxXr9KzR3qZ83DXO0x67tQIQzFyLHHGOftxd48lPFOM48tB5rqkiQVI41kPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLtlenPRhvNrIY3KX8k6YZt8lJVVY/meJ4+9xR9IWvA=;
 b=ZTl2QTax4SzdeKQ7DbtQc16dfFx5ssOtYUkIcPzXA6erJRX9X12+7yCqadGhVO7y0G94vX8f005zXiB4WX1uuDYKE23ytEi5jbmq9B4cMlC7aboRWKDUi8p0JU+K9Nfld5pc3nMrSbg9AFhsxxEmZFNiYtYZIgDfrsqyAUwbuTr6hdWNDEg2KxMkW2THbv9ut6NHAPXzOfy71WSw0UQPGOCIB0S1sMAvHaWE/p2TSo3mvnqAmVHDxtyyCB2/eI7pHWzmPNt9TwChA6xli5RTueUNWTHDr3DRIcknNlBOKl/jimAQ30nA2r/S0565L13IdkD4LDRi5TFI8cT521fHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLtlenPRhvNrIY3KX8k6YZt8lJVVY/meJ4+9xR9IWvA=;
 b=hBSvKXO018DiUip8O8kCACp96tN/FsO4PpHgV1YZL/uXNB2ZHPxGfi6si3ppmm/8k4kYKnp1sBqdKzK1VbcQoIe+aL4VjJvYDUn2yIfHySj1vHm2g057mHQVmarjD11JShMlJjs5jgfC/41FHY9bXRWhSZTrrqo7Ns/Ly+vwA1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 16:56:57 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 16:56:56 +0000
Message-ID: <83dc4e61-86f3-409b-91b2-4a61ae1593db@amd.com>
Date: Wed, 29 Jan 2025 22:26:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: Enable devcoredump for JPEG2_5_0
To: Leo Liu <leo.liu@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Lazar Lijo <Lijo.Lazar@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-10-sathishkumar.sundararaju@amd.com>
 <420b603c-be80-413e-a069-b1edf3f2a04e@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <420b603c-be80-413e-a069-b1edf3f2a04e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 640aae7a-7320-47c4-808f-08dd4085f02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVdIUm5sOGUyRDA1RisrZ3Z3dUdndzRuVTF2WXA2aDRJRUN1QmxsUGJLeGxk?=
 =?utf-8?B?cmtML0xyOXhIcVhGT1Rsd3I4MG8rRFM0YmI5NHB1U2E3V0pyYUNwZ3F5WW55?=
 =?utf-8?B?RDkrY3JOWGJrcll1dTl6ck1RYlQ5MGFxaXl3UGFEK09hWkpwVHl0Wmc0UDJk?=
 =?utf-8?B?SFhyN1ZSMjJhNWJ5aUNkSDduclB4TGEyQXc3azRQSC8xYjhFSEVUdHFDV3hH?=
 =?utf-8?B?dmVGMDVPV3lmWHJ1Nm5JWnpuRGd4bFhOck9Uc3JreHNuMTVkd013Q1ZaZis5?=
 =?utf-8?B?ejRNS05LUEFrdUNnV29ZYkg2Zkc2UEc2MkE2dzZSUVRRN3h2ZWxGdVNlbllx?=
 =?utf-8?B?UVB4aVpEcEN0b3pHam5ZNmJrOWhYbUVTZHZtb0lvMmVMTWxFN0x5dzlVYWMy?=
 =?utf-8?B?N0hQN2NCY1pKQTZCUHJhcW1MeDh1LytRSmFveDl6QkxHNUttMVBTSTk1aTN5?=
 =?utf-8?B?cVV5ZjFUakJWQ0hKclV6Y0gvY0FFdnBRUU9SOGp1RmwvUGdHR2h1MHVCSS9n?=
 =?utf-8?B?MzdYMC91eXVqcWViUmYyN09KbEI3a09xbTQzVjhUZ2lwNHlZSHlUWVhPaldP?=
 =?utf-8?B?cTJNSW1wbEpJNUtDbUo1a1RzVnNPUUU5TmI3bjJ6MkNOUnBJQ2U0YnBxdHB4?=
 =?utf-8?B?b3U4VWxlT3loOWIyS1AySGxFNko5bElOa0NTbjF0dTdIZ0wwc0RvQk5Mc253?=
 =?utf-8?B?eXVieThlYmFhREpMR2JhcGY4dnBzVHJwMDlWd3pkMUozV2RFNW5TOWRlUFVC?=
 =?utf-8?B?UGdxYWowTExCOHpDR3I2eHpZK0ZyL1V2SmdyaWNFRzBWOEVLQm4wUlFIeFI2?=
 =?utf-8?B?WlBnV3hrOHlkUHVBSkRaNXNjME9HL1BPb0VFbkVNTXBEK2Zjcmh6WTBxYTlr?=
 =?utf-8?B?UkZzbkdlbEFTQ1BMYTdzMHdVbDRaanVodDVQV1JFYnJPanBQSjZPODRhMFlt?=
 =?utf-8?B?b2ZzZWRqUUNuSFA0MGFrb1ZpbkNjaVlaWDM5WVhmN3U4TVB0ck4vbkhxYjNx?=
 =?utf-8?B?VGZRN1NvRjZzYWFGZ3U3dkdiWUhVbUlWTGc0MWIyVEZDbUFnanNnR3JTR3pU?=
 =?utf-8?B?OVNUTGIrejkxaDgxWmJhNkloMjE1MkxHZVVrUzhVTXRkak04bjdUbnBVSzM1?=
 =?utf-8?B?MDIwWG9KTTAvY1J4UnduQzV1UlVGR0hJbHRhVlBzWTBCMFZPTnd4WjU0VHBJ?=
 =?utf-8?B?NkFVMVN1TXlRQWtZSXd6Wk1rR0J1V3UvTEhMcDVxZVBIbUVycTN5RWNTTEZh?=
 =?utf-8?B?cnc2cFhSeGQvNTl4RnlyZGFHbHFuM3NPTGtENmk2WGFPVGdmVkN0NGV2TGcx?=
 =?utf-8?B?WDBmS3h4NVRxc2NSREdLclZRQk54QzNTc3pzYzJUNS9DeDBEZHdESmN0bmMw?=
 =?utf-8?B?YUtXbk15UUR4eE1IT3ZLNTl3OFhsbUFpL1BLQVNySitGdzhSbGdzdnE3REp2?=
 =?utf-8?B?YkFVTnFjTkM5VVJTcERVbjJnUC95UFRWL0xIZ3dxa0ZTdUh2Z041UE4wSFkz?=
 =?utf-8?B?OFV5cFU5WXJpRUVZUUt2ckNnK1Q4Q09IRXFmdUkyUHIrQ1VQSkpqYWlvT0hv?=
 =?utf-8?B?Nk9PTnNYdGMwTm9HcUo5WnI2RTBHT0F1VktMTDFsMXVEWkpFYmlNME1hYXha?=
 =?utf-8?B?eEYwVlNqTlJiRXRxUGg4TCtlZjRZZ2V6ZytCVU9aYnd5VEU1UzNBenRWbktY?=
 =?utf-8?B?bWZORU5aVHl1cFpDcWp0ZmlUNUJuczBpODhaQ1c2RjM0STBzYitrRDdNV1hK?=
 =?utf-8?B?a3NXcnpPM3pqMUlWQlhuVnVKa2JOYThlNnFsYXpVSHg1MVZHaGNLMUJndWpS?=
 =?utf-8?B?Uk5lbTRSekF6Z1ZPMDJrUXpIZ09qcWx5UzIybW1LQTA0WTZkQW52TkkxUDdw?=
 =?utf-8?Q?l/erOO3n+IxPT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDE1elNZc1ZYMDdaVUJwUlpzM3dUL0dvaFA2dkVCVE9hV0I0N01LWTQvZGVQ?=
 =?utf-8?B?RlNrV1hzaVRWMktyRFhIbjNVTWNoUzdQTnlBT2NlemNzdm1HSHlzbStpTlh1?=
 =?utf-8?B?enRSQVhyNWIydVBWdnIyT2ZoWlpZd2xPR0tHKy9QN2lQZzhoZWxXdHJnUTdZ?=
 =?utf-8?B?K2JDNldkNldPUnhJSEI2NjR1OFY0UUZ4NzVDWTBEbzhPTGNNZFN0S3VyUnRB?=
 =?utf-8?B?YitwTkFOODBySWdRaG1wd01hREhIdTJ3MXlJTUcyWG5SeHVmbWVUZzJ0Sjg5?=
 =?utf-8?B?WS9tVzV0aUg0NmxobzJMK0JZRVE3L3ZNUE9EeWF0UmlRbGdKM0x2bHhoMTZJ?=
 =?utf-8?B?Sko0bHhLblQzM09YVXJOdHdodkRDaXpQL003b1UvSDBlTEJqaVVEMkJHdUVU?=
 =?utf-8?B?VHY5MFowdnY1VUFZQzBtOWIwWHl3YnRWejlUWEtLelRvWTdSY1d1WDhVQkN4?=
 =?utf-8?B?a0pBQXc4aXBTdFEwSWxuT2JxTEh2VDlWR3ljT1dGditxcE84QTZJMlpoYUxO?=
 =?utf-8?B?bWwrRCtsWWc4RXljbVllR1E2b1VIVWQ4L0NSV1FwQ2tkQWNGdGFNdUNyanhv?=
 =?utf-8?B?OTdIRDJ5aUM3aHU4Z2MrN1JqcFhDeldYTEhCN1FKWnQ5MExoS2l1cTJ2L2V2?=
 =?utf-8?B?WjJONERXaDQ4eVNUdkhNMDBVeUJ3RWh3UUNtNFF3KzE1d0FsV1dwWE51cjBa?=
 =?utf-8?B?Um12QXlGTVM5eUlHaDRoV3prNDRlN3V0azB5aWM4WkFvalphK2FML2p6S1V6?=
 =?utf-8?B?TmtvY2xVYS9HYWtaS3NTRmY0aE5ESlo4VHQ2ZHgxTW9JZXVhbS9ORjRzK3dQ?=
 =?utf-8?B?SXFMbmFQVHp2RlVhNzRsSHJRZ3hOY0ZtZEgxdlRuRjY4TGxHSFNBbXJjOC82?=
 =?utf-8?B?QVBMR2hubTl2NDdZRUFFa2RvZDlPKzRscjZQMFVoeHpsU1ExQmJHbnZZaE5J?=
 =?utf-8?B?SUxubi9Idjk0S0JyY1UxZDJaWEtaQ2xjcFJyZm03UjkvNW9menlQbUlMU3pV?=
 =?utf-8?B?MkpoZmxXK2JSWnB3bHFkR0FXZ3crMUcxcWg3NlI5UFgzbVlqSzdkd2t1Yk54?=
 =?utf-8?B?THRGMXJFMEhyV3R3RzRKRDVGU0pKclBtaWh2Qnp6R3VJSnplaCtWeWRnMjlh?=
 =?utf-8?B?aVYzRjFzenBYeWxxQ1FOM3FoNDZORzgrNWhpVjc4SHpHc3hUSmh2ZndGUkc3?=
 =?utf-8?B?cUhxZ2tMajBCdDFxZkltTHcyYjJMNlNyblpIb1NIVys4OU4zNWdEMmt5WTE4?=
 =?utf-8?B?Zk5ST2xHVEorT2FwWDNNY2ZEN0JnYUQ2dHl0R1NSTmpFbkRBckVweVk4TXlQ?=
 =?utf-8?B?dnFDRXJWb25qL1UrMlBRME5MaGkyeUxBT05ycnVGcTlMeTNTYVREdlRKV3pW?=
 =?utf-8?B?VzBaU0l1b2N6alpsd3hWem1oSVlpSThYdk1lQkgySitQU2F1VTltamtWT20z?=
 =?utf-8?B?THBqQitNM0dnSUZLV3pmaXk1WXJUUmE1M3JpUzZROHhNdE43S3l6NFlZL203?=
 =?utf-8?B?U1dKUS9RQlBlV3NacDlaOFdZUGFlOEo1ankvRUkrQ2YrL29SWnc3eDc2L3JS?=
 =?utf-8?B?Z0FJWHR0NElBcmNjVHY5NG1MUEFydi81eVVVZmdJQkM3dUJlanV6V3lDQjZm?=
 =?utf-8?B?VTZKcDZ2bE5ETzU5aG9IOWlicFFXaWNxOVRXSWdzcHdLbWdyZXFYeUtCZUhZ?=
 =?utf-8?B?REgzcHd1NFlnTU42ZVlnRVFtZ0JxMnYvM2FreFljN2NDQVJnbU9NTEdPVUJ1?=
 =?utf-8?B?M05oYitRdXpVODZRY1E3YkdoZHNTcmhlQklDYzYyQUkvN2hsb0cwZEpCVFI5?=
 =?utf-8?B?eTA0Zm9LdDdjSC8rc2lQNE1vNEMzMEdlaVVFYXkyK29zMGNOOVpXMXdhZ0NN?=
 =?utf-8?B?bDdIbkJNamVVNmtBdk8rTWtHTE5ub1Y5a3FDMGZueG9ZRUFGeDNzeTN6N3R1?=
 =?utf-8?B?eUd0eGRKTzFSaDFoWFRrd014a29yb3JzZXFMR3RBcmRnc2V3dFZBUks1dmRG?=
 =?utf-8?B?TDhKZXN4ektOSnhxOXdkODhUbFNkRHpnWitlVGJydjRYQ2ZBbTJPZE1rVktQ?=
 =?utf-8?B?UThkVzZ1VWFZM2J0TjBQMGl2TWpkT20zejhsUXRhdFZtanJNQXJ2MXRwTGIv?=
 =?utf-8?Q?sfl4kWOwiaBSMVO7F50bj5uLy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640aae7a-7320-47c4-808f-08dd4085f02a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:56:56.3804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/buwviZnkdLeYOKbahbn1/547BsjNIp3+bNynylJZWxt/CPv5wlPCpnpu7yV0KNZJVzJM8uz41Do1/GTdWP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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

Hi Leo,

Oh! I somehow missed it, I will enable it in 5_0_0 as well.
Initially I had some confusion around 4_0_5 and 5_0_0 as they both are 
in dpg mode, but after checking the existing register access I enabled 
it in 4_0_5, but missed to enable it in 5_0_0.

Regards,
Sathish

On 1/29/2025 10:06 PM, Leo Liu wrote:
> Looks pretty good to me. One question that why this is not added to 
> JPEG 5_0_0? Since the patch 3-9 cover the rest of versions, they are:
>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
>
> On 1/29/25 03:46, Sathishkumar S wrote:
>> Add register list and enable devcoredump for JPEG2_5_0
>>
>> V2: (Lijo)
>> - remove version specific callbacks and use simplified helper functions
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> index 11f6af2646e7..536a6101dcf9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> @@ -36,6 +36,22 @@
>>     #define JPEG25_MAX_HW_INSTANCES_ARCTURUS            2
>>   +static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_5[] = {
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_RPTR),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_WPTR),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_CNTL),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_SIZE),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_STATUS),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_ADDR_MODE),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_PITCH),
>> +    SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_UV_PITCH),
>> +};
>> +
>>   static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>>   static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
>>   static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>> @@ -147,6 +163,10 @@ static int jpeg_v2_5_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       if (r)
>>           return r;
>>   +    r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_5, 
>> ARRAY_SIZE(jpeg_reg_list_2_5));
>> +    if (r)
>> +        return r;
>> +
>>       return 0;
>>   }
>>   @@ -168,6 +188,8 @@ static int jpeg_v2_5_sw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>         r = amdgpu_jpeg_sw_fini(adev);
>>   +    amdgpu_jpeg_reg_dump_fini(adev);
>> +
>>       return r;
>>   }
>>   @@ -623,6 +645,8 @@ static const struct amd_ip_funcs 
>> jpeg_v2_5_ip_funcs = {
>>       .wait_for_idle = jpeg_v2_5_wait_for_idle,
>>       .set_clockgating_state = jpeg_v2_5_set_clockgating_state,
>>       .set_powergating_state = jpeg_v2_5_set_powergating_state,
>> +    .dump_ip_state = amdgpu_jpeg_dump_ip_state,
>> +    .print_ip_state = amdgpu_jpeg_print_ip_state,
>>   };
>>     static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
>> @@ -638,6 +662,8 @@ static const struct amd_ip_funcs 
>> jpeg_v2_6_ip_funcs = {
>>       .wait_for_idle = jpeg_v2_5_wait_for_idle,
>>       .set_clockgating_state = jpeg_v2_5_set_clockgating_state,
>>       .set_powergating_state = jpeg_v2_5_set_powergating_state,
>> +    .dump_ip_state = amdgpu_jpeg_dump_ip_state,
>> +    .print_ip_state = amdgpu_jpeg_print_ip_state,
>>   };
>>     static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs 
>> = {

