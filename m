Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0345FD597CF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 03:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C94E10E673;
	Wed, 13 Nov 2024 03:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TwWALL6c";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6716B10E673
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 03:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMioBRk1ElsL6pDdNI01f191NELdNkHhR9GOGhQVoBc5WrWhzRUE8Ck+KTkJiCpVkV6L3EKVYGZXOL8F6c3bzv3l/BYYcKCLcmTu3XgUQIKNv/IuUogbxCwhemv1WHj3nV/DuoAwqdo0OKn8+2pokho4Rsbnfn+wneuD8HuydY40ukI/6PWzbjcqUhfSLT0B/ejimbnFpaEFxj2jfYmaZkFmoX5nzdVDEnWdQ8eqTXCzI7SeJi9FY2NU8JXrutYIMVomai7zHbKO1zkZBRjvbwdvkatvRS2nT9XTN6BHCR6kr7nond5gDYck6UJ97zFnQTepY8XsBIi/WZ2lGK6oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+/h80qV4ZaL6qPd4dYbUV1RVyb2QPUzkI0R9DhxD/I=;
 b=PrunGbZbtlC4u8LKXMd5AFiT6O8nmQFfKDP06kSLtYBrsAb/aGFnBHsRGX+iGChzNzh864ZfU8TyozrY24+mTobZ11Vuo5Hw5qmfOWsBJ0K6dYz9ESpJBuRZmzBMItKV0+e6NJhBVKRGnkJcBYRSFx4gmoYJdXBBxxkX73voAnTHGtCZurXnge1y/ALLjEDB0AWlFuTtu/BZ5/4xBGhNLUrgH4RQFjo0A8p0CgFC+AHoDzOy+ddubRcqlVVCf9HqbNA30o3AGOC+/wUavwcKzQuNUkwOJxGjlCSc83+CqQ65w34yQ+Ls3Mt8UyIyCfNvccLSpCxJuDQJjjtTxExNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+/h80qV4ZaL6qPd4dYbUV1RVyb2QPUzkI0R9DhxD/I=;
 b=TwWALL6cHtz+jp8yflpaSy4sg3sFhcW2QTjCUMY6Vq1aYB7yKQdMzshGqDBwvhEMDgdWBYTHMciPM3PIfjWBHcaE7fYS8p8KjOZWu3GICIoxxKYMtDq8urVLcN+ulNoIryxq6oTyg5ZbRkVHjB6rNxr2ffL6ncyIgVV2IVjH1sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 03:35:28 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 03:35:28 +0000
Message-ID: <e198d4aa-b6ff-4592-8785-dae262f4f694@amd.com>
Date: Wed, 13 Nov 2024 11:35:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
 <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
 <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
 <cc6f4141-a085-41e7-b772-8c400788c1b9@amd.com>
 <d96c1117-7eb9-4c65-ab0a-1f4507d32674@amd.com>
 <87029c10-4fce-4a42-a04b-ed2633c69148@amd.com>
 <bfa7bfa7-c134-4268-97aa-7b9baf899be3@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <bfa7bfa7-c134-4268-97aa-7b9baf899be3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 449da908-6e83-4c3a-afd5-08dd0394379e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0huZXlicVI4MFAzd1BYYzZIMjBoWmkybkpBYXhUV1VPTS80TFA0Qy9ZbXpK?=
 =?utf-8?B?UHU3eVF3MFhKQ0xmVkRBNnJQRHRJb0laeXJYeUxNUVhPY0l6WnNCZzhOWUY4?=
 =?utf-8?B?dXdUT1h6NXBLc2RrVE44QXcyMXNaRFJvRzlQbVpYb1hnRHJocEtwSWtheWND?=
 =?utf-8?B?QlVFTzhKWm94STVxSmYydVlLNk1NRjNGTndXRko4bWZ1MHRxRmx2SWdqT2hy?=
 =?utf-8?B?cUpQY1pDeXVuZFJkRmFwdXBQNTB2RFkyN05WT211RFV0T242OUFuYVRUMUpI?=
 =?utf-8?B?SnpjZzBqVmZNQVRGdmkrcmN4R3JsM0lUc0pZVDZkalRvOXpGYUNpemRzdEhT?=
 =?utf-8?B?azVZV3Rud3dHd3VMSktqZ0xOOW5SRzU5TGhvNjlraUxHeSszcTFqYXhMT0dl?=
 =?utf-8?B?QXA5TzF1VWZjeUo2b0FnL0szQlJrcE0xcWpKcURUQ09ONlBybk5GR3J1OUJx?=
 =?utf-8?B?YldlMzFOc1ZONGkycEMvMngwTjJiR0piTTNRQkFURjVXNE1FbmNMOGVyVEE5?=
 =?utf-8?B?a2gva1ZNUndtUEFLWWdHM2xMU3U3ajgwY2RPcXZPb3BjS3RwSkpsQnV4dkdh?=
 =?utf-8?B?V0xSS0RFN2h6d0tjRXlpRVh4c2RxRDh6TEtjQlluQ3pnRFd2NWFuUlB1bk9y?=
 =?utf-8?B?RUFESjd2YkVJUUpuZks5TGhrRkdkRFZyZU5hdkp5cnM1cThLUUNxQ1BOdGV2?=
 =?utf-8?B?SjJJeDdiYWIrY3BHWGZwZ0JKbGtGNlFFVy9SY213NWplSWFtWlJMNGpxSlI4?=
 =?utf-8?B?YThtM25zaTkvQi9aSkwvVU4veUUwdVdSVjVndnNFaW9LYVpRRE1zMnhQWUdX?=
 =?utf-8?B?Y29yUi9ZM0U0TVNFM3FNd1NGMm5wSUUwclpPci9ja3l2VzVjYnh5Y25YV25D?=
 =?utf-8?B?SXBIUUVQNEgvMUh0UnpvckQxNE9pT3NHN0dQVFhhdjRZZ2xlVXorRW9Wd291?=
 =?utf-8?B?cFVBTDdJTWtya1IwVUtldTRPVEhudTFTZHNrRHBUQlgwQWFXYzBvL0FqM29R?=
 =?utf-8?B?bWFhcDdFSFpCd0tnVlNRRXBHdkl4ZHlBUk1xbTBvdUVma1N0cTdDS2FSZWVm?=
 =?utf-8?B?K2VjSUFaVVhxdk93QmlOWDJBMlZ6ZTI1QWIrNmRRWENvY3gxODlJc0cyeTlj?=
 =?utf-8?B?aXdRc3JkS3hvcmtPYTVTYndYcFBlUFRxaFFpWWMwaG1VN0NDMTZnSHgxMkV2?=
 =?utf-8?B?eURGRXJueStOY0FaN1d2d2F1RW9DeHUrSXhNQjZWdmM2TkxNa0ZBSGJhQkZl?=
 =?utf-8?B?R0N0aFZEVWE4VDhWR0RyRDY1TlZTM3lJT0hmYStNMUY1UnFBZFI5SnRmQk5E?=
 =?utf-8?B?ako2N3NWZlZzSDFBYm4ybkNtZCt3cmJOVTNOZGJwS1RxMkE0VjdZcXM2bmJk?=
 =?utf-8?B?TGJPQ3ozVUFmK0IwYkhRMzRxV1J2YVhYZExWd0IyNWRsOU4rKysvTmRJaGd1?=
 =?utf-8?B?TkVWb2lRT3dnenNOUDZESllyb2FXR0lyWjltbjBKdUY3TmZRbURmU0poTlBF?=
 =?utf-8?B?aXhYWndCVWpvR1ZFeUhTNU9LZkVwRnlpOVVFL08vL0RGV2pnaW93bGVFTlUz?=
 =?utf-8?B?Z2N6K3dqTWZ6L1d2anVRYUpSc1VqcFJZTC9OQ1VkSXRZS1k4cGFVZHlMd3Zj?=
 =?utf-8?B?cko3T1phekNvSStDOHI5QkRpcW1nOG1wMHRXcG51TzJHVWo3UW41SWJSZUFF?=
 =?utf-8?B?dm9TVVNmbHpGRlZqbmZCU1ZIenkvUHdYd0NRUmZFR2RkKzhIT09BenBEZ3RH?=
 =?utf-8?Q?p+eKNN+nY/UTaaUQFv5w9EboeUVOF6eHGk1Fq0q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNYbVc3ZlBoZUxLanZJQ3hEa3VGY0xaVmllcVlFUUhGM2VoRk1Xek0zSU1u?=
 =?utf-8?B?djQ4QmZCRU9rcElQTE44Z3ZDYWozaytDVThjbXEzWEoxQ0VmSGNEY0d5TUpw?=
 =?utf-8?B?b2s4bFB0R0RUa0M1TklPTlFzRlYrNDBCdUdrdlliQkFKaGVqOXRrNHpjRG5D?=
 =?utf-8?B?b2pwcDhIaGx2MHVqOWFlYUExWUt3Z1RwRG03bWhxS0dKQk5TTkRMdmxSMTZS?=
 =?utf-8?B?Y2lZODd5dFY5OWdrTTVJb09zVVBmRmQ5bm5YLzRBUFVoMENaMEtZWlRBb3JZ?=
 =?utf-8?B?Q3hWeTBqcXpDbERtOHFBMC9sUFVkY3NlQXhVajhhQVE0MGgweWxzRU9XdWVh?=
 =?utf-8?B?QVJRejFsOGdYUTdXcHNCVk1JYVlReWJ4TEFXb0NPQzUyaXMwcUNaMnd3ekEy?=
 =?utf-8?B?OGdsYUE2SVlKSnYvSGFYbm9XaXV4YXJpbVNSdTVqc255L3ZpN3pQMmxUYmQr?=
 =?utf-8?B?U0FBeEhJUEx6cnVUMUJZOVc5OUIyYVMyUWlEVEp1S2lGZ2MrU0o5VlZqbjQx?=
 =?utf-8?B?Zk9tQlg4bEUvQ2lxVXk3Mkh4SVJsRjZndXpOd21KYzJaa25jK1h3VmxDL2Ex?=
 =?utf-8?B?WDBKNXpFQjhWeUtWSk1md3dDaVRGOGV1NGVXSGtmdkYrK1YwTWZ3Z2xUZUJU?=
 =?utf-8?B?dkhDZ0l4M2k5TmlaUkw2VTdBbnRFdzU1L1dvT1FudEp3YnMrMnc1QzFuYWo2?=
 =?utf-8?B?OXU2b0RnWnJVK1I5bXQ4MzhHaTh1SVBlYTYyRjZBOGlUNHFVakNmejU4LzlR?=
 =?utf-8?B?Z0Rsa1dET1YrQkFsVWNLcmxrSndHZm9XdDIrMHkyMXhPTTgzRFNiWWRjQ2Mv?=
 =?utf-8?B?Ry9zQUZyVzhLN0hFRTY3dkJ4ODNSVy8yUlVBUG82YkxQUlRmNCsvWVg5emRp?=
 =?utf-8?B?ZG1BZGhCaG1QeUR0NHdTTFV2SDNPTnVBbG9YUkViMXVYbWdsdUJTSmNNNzlB?=
 =?utf-8?B?VEdGK3ZyR3huOUhQc1d1aEI1U2I1REpxZTdvTjZQS3JiTDd2WVpnL1l3bjB4?=
 =?utf-8?B?b05zcW92K25MRmE1R2VtSHQ0cEdzcDBPcitueElUVmpXOS94MVIxWDFGYlZ2?=
 =?utf-8?B?bk55VWNySDBDMERYbXpyVjNERXFXR2FaN0ExVWlpRENVNmpCSkZ3anpEMm5J?=
 =?utf-8?B?QWVDN2FPa01qaTN6emVIOXpxQmJMaDd1bDZsTWQ3Skc0cExPS1Z1bTAvZEJi?=
 =?utf-8?B?U1l4VkdZRHdINERoSFlyRTlNelptU1krSEtiRzZDME5SbFlUeWVTUEd5QUlF?=
 =?utf-8?B?bEp6Rzd1VjIxUXhLdVB4ODJDZ0JEajNQWFJVTmZzLzVtYkgwcGpGdDZBMkR5?=
 =?utf-8?B?VlBqUG5oWExYUi9kSzlRZ0dGZ3B3cDk2OVB6RnRRUjQ1M0VYY0RGWXFLcEMy?=
 =?utf-8?B?NG40K1JlMHFxQzUwcElBajlUZGJVeW5QSFNjeHlBUGpMazNEMUdFcmJOY0Q3?=
 =?utf-8?B?ZG5QZWo3QnpaemI5U241RE1VU3JWay9vd1BRdnR1YzZzSzYxNS9mNm1INGRK?=
 =?utf-8?B?NkRCdHFsc2UvQ1NFR291dWNiZDZHM09yWk5DNmc5R2hyQXMwbVRsSW81QU9E?=
 =?utf-8?B?dGhqZEg2L0QrZzFWcTNVOFBCQUt4bzZ3VXoyQ2FldjM4dTlGQjYxT1UzK3NR?=
 =?utf-8?B?dmxUMjFVZmcxQTczL3VkQlp0UTVWdDQveTU0SEZqYmUvd01xQXpvbGxxbzhQ?=
 =?utf-8?B?ZmtyU1U3SUNWSjcrVFJJT3ZVQVhWbldHZnhPQjQxY0NkUzRMTUJEOEh5YVNZ?=
 =?utf-8?B?VUJHSmNlcTdJTmFhSU1ZcHpoWGo5NklhL0R6MUlIYVM5U0Y5ZTd1NzQ2TDVj?=
 =?utf-8?B?T3lDNVNOOUpVWDdFL01wUXFaOW5ScFBkU01pMXB6Q1l4SmxvRGx2blpxVEg5?=
 =?utf-8?B?V0hncW1kS2JMMmlWd0RXeHlRK0IxVHlmbVRHcld1TWhTcFJZaTEwT25IdWp2?=
 =?utf-8?B?OWJpVjhTMUF3SU5kZkJPZnY0SWdHNWg4a0VmeW9IVmhVZ1I0Q2NHU3JwUmZz?=
 =?utf-8?B?OTlLdnJIYWkxR2VIUktqbW1lejhvREVQWldXbjl3aUtQV0Frb2pZQWg0cnZp?=
 =?utf-8?B?VUxKeHVvR0NJeVdRS051d1BjR2xtOWVSSnM3a3lhK0kvTlRmajFKS3l0SDNk?=
 =?utf-8?Q?Qvi24XbDq/qIZ+rHH/wWXBYsZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449da908-6e83-4c3a-afd5-08dd0394379e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:35:28.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXxJw01Penx30cYhDNcpAvta0twXFTrS9XvjcHClKXXDR1FRkjyB5z2KkdxllzOVrBwjb/5i/dd0HTXvLYvABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

On 11/13/2024 7:46 AM, Felix Kuehling wrote:
>
> On 2024-11-12 2:35, Zhu Lingshan wrote:
>> On 11/12/2024 6:21 AM, Felix Kuehling wrote:
>>> On 2024-11-11 03:08, Zhu Lingshan wrote:
>>>> On 11/5/2024 4:50 AM, Felix Kuehling wrote:
>>>>> On 2024-10-31 22:35, Zhu Lingshan wrote:
>>>>>> On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>>>>>>> On 2024-10-31 6:50, Zhu Lingshan wrote:
>>>>>>>> The ioctl functions may fail, causing the args unreliable.
>>>>>>>> Therefore, the args should not be copied to user space.
>>>>>>>>
>>>>>>>> The return code provides enough information for
>>>>>>>> error handling in user space.
>>>>>>>>
>>>>>>>> This commit checks the return code of the ioctl functions
>>>>>>>> and handles errors appropriately when they fail.
>>>>>>> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
>>>>>> how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.
>>>>>>
>>>>>> what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.
>>>>>>
>>>>>> usually the return code provides enough information for the user space programs.
>>>>> I don't understand your concern. Even without your patch, the failing ioctl still returns the error code to user mode. User mode can safely ignore additional information returned in the argument structure. You are raising concerns about performance or robustness. I don't see that either of those are negatively impacted by copying additional information in the argument struct to user mode.
>>>> Still the questions:
>>>> 1) how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? 2) what if the user space program doing pulling mode, pull the args before error code returned. Memory changes are usually faster than error code.
>>> There are no "bad default legacy parameters". Ioctls that were defined to return additional information in the parameter structure on errors have always done so. This should be documented in the kfd_ioctl.h header, though some ioctls have better documentation than others. For a good example, see kfd_ioctl_dbg_trap_get_queue_snapshot_args and kfd_ioctl_dbg_trap_get_device_snapshot_args, which do return the number of queues or devices in the parameter structure if user mode didn't allocate enough space.
>>>
>>> Another example is kfd_ioctl_map_memory_to_gpu_args and kfd_ioctl_unmap_memory_from_gpu_args, which returns the number of successful mappings if the ioctl fails. This is necessary to restart the operation after -ERESTARTSYS and skip mappings that were already completed.
>> I believe these are bugs that should be fixed. If request N but only allocate M where M < N, the kernel space should return a proper error code and then user space should reduce the requesting number, like N/2.
> That's not how these ioctls work. The ioctl needs to return data for all queues or all devices. User mode may not know that number ahead of time and may not have allocated enough memory. So the ioctl needs to be able to return the required allocation size in the failure case. This is what it's designed to do.
shall we document this? Or how can the developers know about these constraints when implementing changes.
>
>> We must keep do defensive programming to reduce potential risks & bugs, keep our system robust, we should not assume the other side work perfectly as expected.  
> Exactly. More information makes this easier. Removing information that has always been available breaks the ABI and does not improve robustness.
>
>>>
>>>>> You mention that there can be other user mode clients other than Thunk. That's true. E.g. rocm-gdb calls KFD ioctls directly. And it depends on some of the additional information about errors. If you know of other user mode clients that are broken by the current behaviour, please point them out.
>>>>>
>>>>> Before anything else, we do not break existing user mode. Your patch breaks that rule. There is really no room for discussion here. I'm not seeing any reasonable argument to even consider your proposal.
>>>> If a user space program needs to read arguments to do error recovery, then it is a buggy user space program that should be fixed.
>>>> Usually the error code provides enough information for error handling. Why our KFD user space are exceptive?
>>> See my examples above. User mode is not buggy if it uses documented API behaviour, like what I showed above. In the case of -ERESTARTSYS, saving information in the argument structure is also necessary for the kernel mode driver itself, not just user mode.
>> so we need a list to document what parameters are guaranteed to be safe to read in user space?
> I don't think it's a safety concern. If you make it one, you need to define what you consider unsafe. From the kernel's point of view, user mode can do whatever they want with the data returned to user mode. If user mode ends up crashing because of it, that's a user mode bug unless the kernel violated some API contract.
>
> That said, I did point you to API documentation that explains exactly what ioctl args contain useful information after certain ioctls return an error.
>
>  And Kernel must always make sure the parameters are reasonable even when ioctls fail in the first place?> I am not sure this is a good practice, we don't see many drivers rely on this kind of design.
>
> I disagree. You can see the same behaviour in drm_ioctl.c:
>
>         retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
>         if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
>                 retcode = -EFAULT;
>
> 	...
>
> This is the ioctl handler used by many GPU drivers in the kernel, including amdgpu.
>
>> Here is an example explains why this is messy:
>>
>> kfd_ioctl returns -EINVAL if the requesting ioctl number > AMDKFD_CORE_IOCTL_COUNT. Here no kfd ioctl functions are invoked, therefore the arguments are not touched, they are legacy values or random values, even all 0.> 
>> Other kfd ioctl functions, like kfd_ioctl_create_queue and kfd_ioctl_destroy_queue, they also may return -EINVAL, but the arguments may be modified. How can the user space tell whether the arguments are modified by kernel, containing useful information, or not touched at all?
> They know by reading the API documentation.
yeah, so at least we need documentation, at least comments in the source code.

Thanks
Lingshan
>
> Regards,
>   Felix
>
>> And what if the user space pull memory changes of the arguments?> 
>> Thanks
>> Lingshan
>>> Regards,
>>>   Felix
>>>
>>>
>>>> Thanks
>>>> Lingshan
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>> Thanks
>>>>>> Lingshan
>>>>>>> Regards,
>>>>>>>    Felix
>>>>>>>
>>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>>>>>>>   1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>>> index 3e6b4736a7fe..a184ca0023b5 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>>>       }
>>>>>>>>         retcode = func(filep, process, kdata);
>>>>>>>> +    if (retcode)
>>>>>>>> +        goto err_retcode;
>>>>>>>>         if (cmd & IOC_OUT)
>>>>>>>>           if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>>>>>>>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>>>       if (kdata != stack_kdata)
>>>>>>>>           kfree(kdata);
>>>>>>>>   +err_retcode:
>>>>>>>>       if (retcode)
>>>>>>>>           dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>>>>>>>                   nr, arg, retcode);

