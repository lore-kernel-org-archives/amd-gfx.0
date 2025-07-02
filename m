Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475DC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 16:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C6010E744;
	Wed,  2 Jul 2025 16:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0USmks9";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0DA10E74B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 16:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFaSmjasXyPB5/PGBpFo476YheH7yJwCwC3CFstO6jtZ/qzXh+sesSIpRWz7AFO5BOhZ4xenjtvXH6bdQ+VL/lk347JGTFtcNJ/PV5ilRVsJVVjMpzjHLVO3Do4daVKmwPb1rW5NtIuDA3VN6HXjcA6vIdy5W7AZP0m9gMvHPD1Rx5tYxYaZNwAJgI/4Gvjgk6Pj7gMSo8yTCTEHDGsCyoRlS8AJgnsGTdIRMN//+jP5aE44+GMu+vI2c0WNzgQap2AD+QOP4MPU6C6ac6iK5gdtNEaug/rBvwyDDslpIPl18dgyu40WoUfMr7qyptl9ovjheC4qucx9B8IZYvZzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSj8hHZwUNCicKoCcrcudZiDyJemWqMB5Hoa0fkdtdc=;
 b=UlU3rubwTxrmYy4auvGRQ5Fh0n7Jbz2DwYz/180331ikimti3+Qd3IA0q2M3pgjWLTst5Y3muLf9S+BrAqYHakeCZ5s0m+7T0MngKoQwqo7bkqL8o6R4xsDkctYWo6mtA3VKgRW7aUw4UWhlCm7lBZTenr4Tb9XOSI6gkxlc9qChkXWaJZdjZ6AZrSn4WkIgpxQLfzIC2CW41vIp/OTcdRJIzrm+QM7LSkaXj9nRMVAN7mrhKHYEz/RXFXgGVzzgDk9pJFF6kgRwNd7n/amzFp14FzPjO9NxW6swvdpM5J4MDV4BE5FZMM/KQ5R32CjvkmKTRAuy1SW9yfykcztdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSj8hHZwUNCicKoCcrcudZiDyJemWqMB5Hoa0fkdtdc=;
 b=d0USmks9L2rQCBete08+jpR8qRn+O6rXox1eP7taWO8rjoAtJUMwGmOb66XWEpz/C221eIbCSe0WeGVH/AhWIBKkO/Yd672QZDu3zUjeSFrxOGDKbpieO+mzq0A5Lx7lnjPFKynGr84sNeYBvVmy9fPtJr1DawXPBgWVUXg9e7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 2 Jul
 2025 16:41:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 16:41:03 +0000
Message-ID: <2ee49f02-e7cf-197a-a6dd-e66b22c57f81@amd.com>
Date: Wed, 2 Jul 2025 12:40:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20250627051204.62029-1-YuanShang.Mao@amd.com>
 <PH0PR12MB54205C1B34B693720538A914E045A@PH0PR12MB5420.namprd12.prod.outlook.com>
 <a3b5cc3a-f863-b845-989c-ddd6ac953a52@amd.com>
 <CO6PR12MB5409AF9DD130FFD6323C1A49E041A@CO6PR12MB5409.namprd12.prod.outlook.com>
 <ecd7b192-84af-4e3e-82d9-4283ca14fe4c@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ecd7b192-84af-4e3e-82d9-4283ca14fe4c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: a20a0a01-d49a-43cc-8bc0-08ddb9873bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2JWa3JsL0F1bkxhNEQwS2hIOWpPMm9BOVd5T1MwRnVjNkZFUDZmblF0SHFI?=
 =?utf-8?B?ZUoweUJBRlA0cUFmMjRTcW53M0s0RExwcjVReTRXY1VSYWtaL0ZHckxNSTNy?=
 =?utf-8?B?Uk0zRUpuM1AvSzhXRUtZNW9MVmp4UjAzbWxtQ1Azd01VUnErSmhreFNQbFRK?=
 =?utf-8?B?VzFkOCs2Y1NvcGY3Zis2RElzV1d3VTRhWWVaeG83WC9mcW5XUURvZXkrc3RF?=
 =?utf-8?B?b2tJdXpTZ0FKTDFxVUdHM3hoV0R0dTA1c2VEVmVyUW4yN3lRRVg2MndKSmFi?=
 =?utf-8?B?aFBsZklzMFY1VnRWWmtVMDBpTjRjNklyUHhQZ3Y5YklpVktnbjR0Zk1ISURu?=
 =?utf-8?B?a2F4anVVV3ZyZ0ZBTlFpR1Z6LzlrOU5rNUxvWE9BekRxeFBhZGtKdW1uSklD?=
 =?utf-8?B?ci9EUkhnY3N2RjFQWmlPcHVBUzdtaFVkSDR0UVphejNaenRMS0FhV2NydFBM?=
 =?utf-8?B?UTcwVGtuLzkrRnNxYVdFTitQL3lTVktsVHpXblRzd3BZM1EySWJwMTBlOWFK?=
 =?utf-8?B?U3M0dkZCN0N5R3FsQ2hBcFpKa1d2TEZ3bVAxb2tMVXE0K0FMZGhKZG1wZTJ5?=
 =?utf-8?B?bkEwN3doQ2hqb09tR0liL3hpNlJ0ckpSLzlIajlpQWwwUlJQUmFSTEJ0Rmdj?=
 =?utf-8?B?TE5vVE1QK2tvdVM5NHBIVmg5LzhkWTVMbkFtWEU1Z2w4RDFFbStqa1YydDM2?=
 =?utf-8?B?bktHM1l0cjVQS0wveFZOVndiMVNZNDRZeWU4U3lDYTBzTDNRS2crMFN3SUJX?=
 =?utf-8?B?VDA5OVVhbXRKSmRDYWRuVXRNKzFIalRSM01VTU96Y002azhSSEZScWJ6TVZ0?=
 =?utf-8?B?N1pabzBQZDZSR0lmR1BoL1RUWXEwUmo4dFc0eUlYUXVqNDUwSnFGeU1Vbm5E?=
 =?utf-8?B?MzJ5NGRCS1F5dCtxSjMrYUl6U1U1ZGpMMWtEL2xzY3Z1RGJ3K1BzNnIvenZJ?=
 =?utf-8?B?S2NvVktrOWttbmZQRDIwS0xERDc5YmFpR1NhVmhTWEticVVLUDdmR3M5K0FV?=
 =?utf-8?B?MFoyeGRsa2I1aU5oN1JmYytYTjNYNU5nTGxMcVdudWJ0NFQrV1pJakQ1ZlJl?=
 =?utf-8?B?VmdPQnhGcGRkUnd4U1lCZlZlL05LN2FtZjJkZG9QR3BYcjIrYXJrcWJkMlkz?=
 =?utf-8?B?WFpOZmkwbGN2c1VoWHd6aW1SRzFYVTFOK3Jmd3p0eVAvQm1ndlIxRGRoUlB4?=
 =?utf-8?B?SXNsRllHQlY3em1qNkZCaHVaUXJsdndFNmcvYXdTaTFoVFUyd092eWFsOWZ1?=
 =?utf-8?B?V05OWWhXamYrbzNaV2I4ZXlicGVIYnNiOWxyNjVPM3pNNzNabDgya2haeVJQ?=
 =?utf-8?B?R3lwUjEwTCtGek5mWjdCUndQTkNvdkcxTkhOT1hpckV6eWJYS0p1bjdYTzdX?=
 =?utf-8?B?c091QjJGYTZxQ1VTS2tGNHJFVjF1VmoxWFhZVkU3OGhCTGZCRlJJaEQ1QitE?=
 =?utf-8?B?M050UktsTnU3c3VwSlF2VUNDd2Z2V0dWTHNoaGZZVjUxanRqcDFEV0JNT0hr?=
 =?utf-8?B?WFlzdGVkVndQRW9za1MrQTNRZ0hFS0tMZlRqUklKanZRVG1BTkg0UFdYV0dF?=
 =?utf-8?B?Q05xSk53eXphMWovc3ZqdXhzaEFWZnVhT3lxUWFzQlJZWW9scHhPeHpFYXFU?=
 =?utf-8?B?YStUbFJvdWZBQmE4YTB5N2tPV3M0MEtCZ0o1WDlIYjRhUXdjanZCU21RTDFm?=
 =?utf-8?B?ZkNESVR3UFo0ZDUvcE92YWdOZ0I3aGNRTTNVUmZGZ2F4RC9EWFZWcjhOM0U2?=
 =?utf-8?B?VVBaRDlsQldXZW9jVDRUVGIxSlhnWFdYbVBkWXk0REREaElwZUQxelNzbVc3?=
 =?utf-8?B?OWlNUS94UG5aNFdGNk5CUHl1ZGhkUzRLeEJYMmpCY0M0NURxVUs0V092aWZV?=
 =?utf-8?B?cytPVzJiaURvQ3FaKzFPV0JaQ1dMemJnUjFaVW1RQVJXaTVkTVVIaFRDVXhx?=
 =?utf-8?Q?JWkEKUZeJTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVXM1RPREFqYmlzR01yQVdEYzV3N1pXOXJwOEhqdEpEWWhHdXZ1VjVaMXJI?=
 =?utf-8?B?TGJzS2NLMGxnRk91V2FFTVdwdGFSTWNBeWc2RGU1cmJDRmN2QWVxMnFLaU1H?=
 =?utf-8?B?bUlWMzJLZU1hb0RSL0txd1RnQm5uY2hJWGN1MFpxNHNSaHRUVkE3TFdSSkhk?=
 =?utf-8?B?d1ZsVUoyYnk0b29ybmIvakc2Y0ZXWU4yV01INWVSa2UzeEFqa2dTK0I4NWYx?=
 =?utf-8?B?RVBNY2RUUmgyU0ljUlhkRXBKOVNzK1NjU3VqTXNNcllhSy9hNDNpTzZUOXpz?=
 =?utf-8?B?VFJ3ekVkSUFGcUgvVzdDSU41VlAwRmRGMGNOdHExbk5DU21DbEdHay9WRkhp?=
 =?utf-8?B?S1RIbTRnNFpVT01TdjR2S2lqcEpVV2NJQVlOUzVoVEZXOE5WWk43eDB2OTJh?=
 =?utf-8?B?RktObllsWnB0MkVmNXB2eGtaTTRrb0cvVHBHVHVjalRjc3pwTE1SZDdtbWJn?=
 =?utf-8?B?bmRnZ21aeFF3ako2bnJIcW9zQTZBL21nbUdDcDU1dmF4cVp0cEFROWFWbFI1?=
 =?utf-8?B?VWFUMkVmR1hZSTh2TFliblM5MU9VZUo4ZERwUXdLcHgzcWVHdTZzeTZRYldD?=
 =?utf-8?B?SVQ5UVgzOWd6eCs2RXhTUy9vWWtnMGFZaXdjdG5UbFpSUExwcGVEckRUZ205?=
 =?utf-8?B?WXVOcHZVOEpmTllIeUp6bDBmSHpPVFpYMlNpbzJqSUxOTGZJMVdWU2JJY3lQ?=
 =?utf-8?B?K001bkNRL0lYNGsrVmlGdzZYcGRkZUMxSjdjNmFKRWtvTHhFcDZpYXVWTEpG?=
 =?utf-8?B?TjhVOFJHR09ZbHN5M092RG9XNnBUaHlOcGtrVDF6UXpQaWF2R2tvSFYzUDVG?=
 =?utf-8?B?NWx2TFpWNFdtVDB3bWZxekdWSnFLV1FubXVkbWk2T3djTTZieGV2VmN1dkds?=
 =?utf-8?B?Y1ordHFpUEd1K09HSE00MFFVSnFvWFFmL0FXVU9SMEJMR0NtcGorU1RvQno0?=
 =?utf-8?B?QklseGVnck5NTC85bWlyTG5FRVIvNDVzODZpRndML3dKQmhvMy8xZDdSWDVn?=
 =?utf-8?B?R3JFeTBlQmJUSmZQYXdCcWlYSlozYUExZTlCUFBVSXZNYzZNTWc2QzhYb2JJ?=
 =?utf-8?B?b0R5LzNFaGlKSmh4cStwZmNSQmgvTnEwSmE2eFhndVpNbGUrRFNIWFpFb0Z0?=
 =?utf-8?B?ZnNUL0pQTGtrNXZwUXV3ci9mQ0FxbXlsZVlqb1BSMFpVT0poakpEbWNSVEpx?=
 =?utf-8?B?aUhpUGVySGdLcER2WEZ1UU9RWXJEUHNxd3lBcDVJaXdoQkhxcjljM0tXbjRI?=
 =?utf-8?B?bzVUVVNycW5TdW9hVjZYMnlHZm1SeVZoMlBPaWt0VDdVb2gzWWxadXhPMVd1?=
 =?utf-8?B?WmVDNmJqUVVMaFI1Qm5FVTIvQ1piYjcrNFBNaUJUZStWSk83Rk9PdkFjdXRF?=
 =?utf-8?B?QUhwN2RxV1JXaUZsQytVbGFDR3VjR3dtRzgzcHJWdjMyb3JrSHh2RUNHQVpj?=
 =?utf-8?B?RzY3T2pKem1pMGFpbGRIbEgrVWpLT2lkWHNXeVg5eGdyUTBUSUFhUUQ4SkQy?=
 =?utf-8?B?cTY2OGl3aGxpWUQ1MzMrM3h1ZzM1REVsM3R1R3VteitoUys4WFlDN0hmSXFY?=
 =?utf-8?B?RXd0MUZKcksxbGlMNXh5UlJ3Vm1zZHVJZUJuZWIxOVZNSFpLYWxHL1JNWFli?=
 =?utf-8?B?cnZkVEQyc1RlK0FZQ2hiRC9xQzh1ZVY5N2p1NjR3RGhEOEp3MGFGM3o1WEUz?=
 =?utf-8?B?eEhuVEUvT2FHT3pUbW5PRWo5akwrZkd1WXJ4dmpOK3RxMnpkcE1US0JrVDFE?=
 =?utf-8?B?cmo2MVV3RkZGejl4SDFBZUN6Q2xETEZ3TEIvN3E5eCtNRm1GMDRNTXVCWHo5?=
 =?utf-8?B?TVFVM3hXM1Z3Lzd5MldVeFhvekJUQWZRLzRRSFlCSE1TdkhkSTFFKzNIZU03?=
 =?utf-8?B?T2RPVXdYOHFyNFIrMyt1UGZjb2U2YUI2cHZkc3QrQnYwbXI4SGVNU2p0MlBt?=
 =?utf-8?B?bVdKczUwd3I5SEFsVnhHby9lTnFDMXowVm5mVHd1MEZzYXBWTGt1SDYrTVVi?=
 =?utf-8?B?Rll5YlVQMmZnVWV1Ujd6ZzdoRWwwV1A1SkZJbGRCSEI4MHZxcWJCMy9TRGZu?=
 =?utf-8?B?bnlqZFhpYWIxZGtUNWkrU0t4VDAySjM4S0hFL2J2ZkNiT1BKVDNibzBZc21U?=
 =?utf-8?Q?K/l4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20a0a01-d49a-43cc-8bc0-08ddb9873bf7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:41:03.5829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCzHgx2xA3axpTprO7GrOaS4pnap+hmVbXawzRBrD3w6NROwQjpopi7sygJjbiiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
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


On 2025-07-01 03:28, Christian König wrote:
> Clear NAK to removing this!
>
> The amdgpu_flush function is vital for correct operation.
no fflush call from libdrm/amdgpu, so amdgpu_flush is only called from 
fclose -> filp_flush
> The intention is to block closing the file handle in child processes and wait for all previous operations to complete.

Child process cannot share amdgpu vm with parent process, child process 
should open drm file node to create and use new amdgpu vm. Can you 
elaborate the intention why child process close the inherited drm file 
handle to wait for parent process operations done?

Regards,

Philip

>
> Regards,
> Christian.
>
> On 01.07.25 07:35, YuanShang Mao (River) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> @Yang, Philip
>>> I notice KFD has another different issue with fclose -> amdgpu_flush,
>>> that fork evict parent process queues when child process close the
>>> inherited drm node file handle, amdgpu_flush will signal parent process
>>> KFD eviction fence added to vm root bo resv, this cause performance drop
>>> if python application uses lots of popen.
>> Yes. Closing inherited drm node file handle will evict parent process queues, since drm share  vm with kfd.
>>
>>> function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can
>>> be removed too.
>> Sure. If we decide to remove amdgpu_flush.
>>
>> @Koenig, Christian @Deucher, Alexander, do you have any concern on removal of amdgpu_flush?
>>
>> Thanks
>> River
>>
>>
>> -----Original Message-----
>> From: Yang, Philip <Philip.Yang@amd.com>
>> Sent: Friday, June 27, 2025 10:44 PM
>> To: YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; cao, lin <lin.cao@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
>>
>>
>> On 2025-06-27 01:20, YuanShang Mao (River) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Currently, amdgpu_flush is used to prevent new jobs from being submitted in the same context when a file descriptor is closed and to wait for existing jobs to complete. Additionally, if the current process is in an exit state and the latest job of the entity was submitted by this process, the entity is terminated.
>>>
>>> There is an issue where, if drm scheduler is not woken up for some reason, the amdgpu_flush will remain hung, and another process holding this file cannot submit a job to wake up the drm scheduler.
>> I notice KFD has another different issue with fclose -> amdgpu_flush,
>> that fork evict parent process queues when child process close the
>> inherited drm node file handle, amdgpu_flush will signal parent process
>> KFD eviction fence added to vm root bo resv, this cause performance drop
>> if python application uses lots of popen.
>>
>> [677852.634569] amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
>> [677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
>> [677852.634820]  dma_fence_wait_timeout+0x3a/0x140
>> [677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
>> [677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
>> [677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
>> [677852.635208]  filp_flush+0x38/0x90
>> [677852.635213]  filp_close+0x14/0x30
>> [677852.635216]  do_close_on_exec+0xdd/0x130
>> [677852.635221]  begin_new_exec+0x1da/0x490
>> [677852.635225]  load_elf_binary+0x307/0xea0
>> [677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [677852.635235]  ? ima_bprm_check+0xa2/0xd0
>> [677852.635240]  search_binary_handler+0xda/0x260
>> [677852.635245]  exec_binprm+0x58/0x1a0
>> [677852.635249]  bprm_execve.part.0+0x16f/0x210
>> [677852.635254]  bprm_execve+0x45/0x80
>> [677852.635257]  do_execveat_common.isra.0+0x190/0x200
>>
>>> The intended purpose of the flush operation in linux is to flush the content written by the current process to the hardware, rather than shutting down related services upon the process's exit, which would prevent other processes from using them. Now, amdgpu_flush cannot execute concurrently with command submission ioctl, which also leads to performance degradation.
>> fclose -> filp_flush -> fput, if fput release the last reference of drm
>> node file handle, call amdgpu_driver_postclose_kms ->
>> amdgpu_ctx_mgr_fini will flush the entities, so amdgpu_flush is not needed.
>>
>> I thought to add workaround to skip amdgpu_flush if (vm->task_info->tgid
>> != current->group_leader->pid) for KFD, this patch will fix both gfx and
>> KFD, one stone for two birds.
>>
>> function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can
>> be removed too.
>>
>> Regards,
>>
>> Philip
>>
>>> An example of a shared DRM file is when systemd stop the display manager; systemd will close the file descriptor of Xorg that it holds.
>>>
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: amdgpu_ctx_get: locked by other task times 8811
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: owner stack:
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: task:(sd-rmrf)       state:D stack:0     pid:3407  tgid:3407  ppid:1      flags:0x00004002
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __schedule+0x279/0x6b0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  schedule+0x29/0xd0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amddrm_sched_entity_flush+0x13e/0x270 [amd_sched]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_mgr_entity_flush+0xd6/0x200 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_flush+0x29/0x50 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_flush+0x38/0x90
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_close+0x14/0x30
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __close_range+0x1b0/0x230
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_close_range+0x17/0x30
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x1e0f/0x25f0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __count_memcg_events+0x86/0x160
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? count_memcg_events.constprop.0+0x2a/0x50
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? handle_mm_fault+0x1df/0x2d0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_user_addr_fault+0x5d5/0x870
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit_to_user_mode+0x43/0x250
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit+0x43/0x50
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? exc_page_fault+0x96/0x1c0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x762b6df1677b
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffdb20ad718 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000762b6df1677b
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 0000000000000000 RSI: 000000007fffffff RDI: 0000000000000003
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffdb20ad730 R08: 0000000000000000 R09: 0000000000000000
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000007
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: current stack:
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: task:Xorg            state:R  running task     stack:0     pid:2343  tgid:2343  ppid:2341   flags:0x00000008
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  sched_show_task+0x122/0x180
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_get+0xf6/0x120 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_cs_ioctl+0xb6/0x2110 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? update_cfs_group+0x111/0x120
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? enqueue_entity+0x3a6/0x550
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl_kernel+0xbc/0x120
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl+0x2f6/0x5b0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_ioctl+0xa3/0xf0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x11ad/0x25f0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? ksys_read+0xe6/0x100
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? idr_find+0xf/0x20
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_array_free+0x5a/0x80
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_reset_ioctl+0xbd/0xd0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl_kernel+0xbc/0x120
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __check_object_size.part.0+0x3a/0x150
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? _copy_to_user+0x41/0x60
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl+0x326/0x5b0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? kvm_clock_get_cycles+0x18/0x40
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pm_runtime_suspend+0x7b/0xd0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? amdgpu_drm_ioctl+0x70/0x90 [amdgpu]
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __x64_sys_ioctl+0xbb/0xf0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? sysvec_apic_timer_interrupt+0x57/0xc0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x7156c3524ded
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffe4afcc410 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000578954b74cf8 RCX: 00007156c3524ded
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 00007ffe4afcc4f0 RSI: 00000000c0186444 RDI: 0000000000000012
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffe4afcc460 R08: 00007ffe4afcc7a0 R09: 00007ffe4afcc4b0
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000578954b862f0 R11: 0000000000000246 R12: 00000000c0186444
>>> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000012 R14: 0000000000000060 R15: 0000578954b46380
>>> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>>>
>>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 -------------
>>>    1 file changed, 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 2bb02fe9c880..ee6b59bfd798 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2947,22 +2947,9 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>>>           .runtime_idle = amdgpu_pmops_runtime_idle,  };
>>>
>>> -static int amdgpu_flush(struct file *f, fl_owner_t id) -{
>>> -       struct drm_file *file_priv = f->private_data;
>>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>> -       long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
>>> -
>>> -       timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
>>> -       timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
>>> -
>>> -       return timeout >= 0 ? 0 : timeout;
>>> -}
>>> -
>>>    static const struct file_operations amdgpu_driver_kms_fops = {
>>>           .owner = THIS_MODULE,
>>>           .open = drm_open,
>>> -       .flush = amdgpu_flush,
>>>           .release = drm_release,
>>>           .unlocked_ioctl = amdgpu_drm_ioctl,
>>>           .mmap = drm_gem_mmap,
>>> --
>>> 2.25.1
>>>
