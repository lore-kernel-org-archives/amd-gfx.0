Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8FEC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63CC10E5FE;
	Wed, 28 May 2025 13:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6WcLxdV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FBD10E614
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHxcQqApUr6HtnsCeD4/+2TjoiahonhR7470JzcAjrnElyj1bsD9JaWdSZo1v+zkhbyCbGuyJV9VqPecg4F0JAcr+tcihBxtHsMtO4qfpGLtyrkDtu9djIX96a6vnBcWittXBG0lKlvPuHGY+esMpNM8eIdtyuaW6jDfujUQRODuSYj8F2sipL/NQSiX3tg3RfA7R6E78CMWlsEAQ9qAAqmQYdGeUdZi6dzIe/DOShAlzhNTpiMBK0RRojwqK6UypNZ6H4S1AM6c4+8WH01A1u+CiBm2UUIM9WHc8DsA/IBZ7Qzmq9NoPdvpgXcJ7wJPbo60xBMdd3U36VOhfyTFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd1NGeNH9yeQxd2ceGufiPCE3IumO9jCNkrTIp3iKtg=;
 b=NRWI10cvYtI3G2mrEwgqx8rIX2uHhLOFX769gJE88oxD2L3FmzKZ2vYccuRPvmHHxrtnXr7QKJiS/Lb0obWcZ5tjIMSZjDRLr92Q9sja7OTLZI7IyTqUjIqcFnooOe8J+yCiBzYu0IdOp48ic2BmHo2Gqpp3WF/kYmPxvAJM9UcV/jeNqWydmCcwqKRHy7Gr21y0OvxAMAW2W9C0jGGimDpCTqqfCnOVj6agOUttHDjNtDjJnyKDjphQ2+Uroe4/Sp6ydAX4pJdWF8Ly1BaiX2VpCQlonZ2NmsZ//wvsItbGN+cSlMRMGwHlou00MVTHwC+yijzsx6lpaQyMSBOuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd1NGeNH9yeQxd2ceGufiPCE3IumO9jCNkrTIp3iKtg=;
 b=O6WcLxdVhENtLG0Np6GoPq27743k9ECETtRaENOU7nfUMxJZgUTj2NB+8X9yTU1nxQEBMDJzYzKGEVqp84HEGxtC2WCPUYOHHgfTl6Z3hZ4Zd/0rYDAcRv4sY2ZBkPOi3QZ0hDhpObC88L7ADmtIfSzN5y9DLI0bjt4HnAGS1v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 13:42:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 13:42:47 +0000
Message-ID: <d8fd14ec-6c5b-4719-9bca-6f4c732aacab@amd.com>
Date: Wed, 28 May 2025 15:42:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] drm/amdgpu: pad ring in amdgpu_ib_schedule
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-11-alexander.deucher@amd.com>
 <7299c780-8d32-4840-91f8-0056d7acdf52@amd.com>
 <CADnq5_PaFMC+VxnDmeqXZLqj7_0ifwgLpVB5aVw8x3VghK2VaQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PaFMC+VxnDmeqXZLqj7_0ifwgLpVB5aVw8x3VghK2VaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4a1ed0-5448-424c-f63d-08dd9ded8809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEVqSjVmRlJmWkZVdUVpSVBkUitOelBBNEpUOEx6MzFIUlZmWjlieWpIdldC?=
 =?utf-8?B?eXRoZ1pnQUgrTUk0dmRHUFp6bThwQ2ZVRGFtTGVGdzNodjc1cjFSOHNUNG4x?=
 =?utf-8?B?TE5aRnVvZ3N2dGQrM2UveXpqM3hqMSthME56OG5lbStmZmJjNEJGeGdNVEFR?=
 =?utf-8?B?SDRLWnJxaFhnOGZ3eWIxMjFaeFhrSFZOVHNOVHVYdlg1T0JGeGxLejRSUURS?=
 =?utf-8?B?SEdNbmdodkRSREVrc2o0QTlIY2hHWGd6Rk5Wb01CNTMvZ29vV0l0bEpMM3Fk?=
 =?utf-8?B?MHFSQlRkZ0dnN2UwSlA2TmliM3o1R1BHZWV5VU5EL2VVMnNlWTlsRlBvYkQ4?=
 =?utf-8?B?bFRsSUN0dC9RYTJqQmVPUVBLTjg1VHJrdHBuMzhyZkJBZHNrUnQ3S3I4TEhG?=
 =?utf-8?B?eGVuTUVGd1huUWRxN1FmMFZwdkRGYWlkUFR6NnNaRzFVVGdKS2JTTk44dEdw?=
 =?utf-8?B?M0Q0MjMvUXhrTmV2c3hqeVhIb3Fad2pMUU5TQWlIVFdNSGdVMUc4dzlIYW9H?=
 =?utf-8?B?SUFKYWp1Nkk2eFdnUnNLUU1kLy9yRWIwUUplSlZ1bnpyUkhkRFgxZFV6VW1p?=
 =?utf-8?B?QkxySkZlOWVxRjczcG5xMVpyWnY5YnY0Q2FJR3RxWVN4dUkrcThsNDNFS1ZY?=
 =?utf-8?B?d3VzRndGMnduOUl0Und1b0lUa2hjVXVldzFGRVBSc21PaXdBcWNRMnBTampH?=
 =?utf-8?B?UkFWR3NHbWlSTjRraDErNHY0NUZ2SENqSjZpTGgzS01XRVpNcUdXdVN6bnVs?=
 =?utf-8?B?RVpRcXFMendRdEJmZzRkWXNyQ1NhaUJsUG9iVEVKN3EvejEwNGlVUXdCcHdH?=
 =?utf-8?B?dnhDcDl1amxKelVicjZKNE5mTUFsVG9UaDllUnE4aU5HRXhSMTZKZGxSM08r?=
 =?utf-8?B?TXovUmNFd2J1NjZjTFlHNUpNVlBCMGJmWHBpbnBqeUl5cmhrYk1xTUJCd2c0?=
 =?utf-8?B?N1RBSVFCbUhsRm1wK283NnJ2ZkhuQWF0UVA5eFMrN0FxM0huUXBBVnN1dmNO?=
 =?utf-8?B?UkNjSG1hNDlYM2VYbDBQYmJVNTBqVFhycFBXcWxHZW9PdEl0SEVWUTNLL1E1?=
 =?utf-8?B?eDdOVXRlaDRXUVF4OHVsVTJrQXRxQ251S2JVVXllc0F4NlFjem83dzhpWVE1?=
 =?utf-8?B?R1FhMHZheWlvUXl5QW1aV25PMk5KcnN2dkpPUzkrbytFak5ZNGlvYWE5aFQ5?=
 =?utf-8?B?QVhpZk5VNEY3ZWI2K0trQ1g2WTFCeGhWOE1qcTd1aExmQ0ZpQXlCSWVoUjBM?=
 =?utf-8?B?QWhoeWRiV3RWQlF6dXlFeThKaVNFOGxlak1uYkxYODBrTU5WVHB0d3puS0or?=
 =?utf-8?B?WXZ3RVlRR0Q4d0gzUExWRy93STlselFmZVVBNHVuODlneUhTRjBIYW5MMnB0?=
 =?utf-8?B?QTRvcmRjYzRIdjhnbFR0dEpYVnovNjRPa1hncU5KSjlkaHp6OTlFYkMvNTRm?=
 =?utf-8?B?RWNRVkVYRHhjZTh0SytLS2U5MnlMVWtEblRDVmc3K1BEb2NKZXRRRFpCVmdC?=
 =?utf-8?B?VUFYb2Z2eU9DQUdWUlBIaFBMZ3NJQmcyTmNEcWwwVTFzc3AyaitKVUphckdh?=
 =?utf-8?B?NVMrS1EvbXN2Uk1sS0k4VlFBS1F5SFRCK3ZOVzdwMm5rb2cvQUdMTytraWZm?=
 =?utf-8?B?Q3drUTJjbVU4dzI0dlYwekVVZ24rMzFPRU00aHQ1OVJ4ZUZHb0FieTM4bk11?=
 =?utf-8?B?Q2tqaGg2UXVEVW52dUgzbWNMdlR0WUpXNFRMT1ZkMTF4RXBHUHlnL2MrSExR?=
 =?utf-8?B?QTh0RkFzTWZUWFpVdlV2R1lwWUtKSEoxNnpqQnhJd2kxMERsSWp3dWxMbzFR?=
 =?utf-8?B?Zm5oWElKcnJWZVROLzU3MXd1MHBpZlFHTmY5WHFwR3l6V2pFeTZiUjRkTFVW?=
 =?utf-8?B?TGR2V3lxMFRiN05nc25PUldENnNpZ2NQVmUwTStCS3FPdlYvWEd2WFNLa2JE?=
 =?utf-8?Q?Eu4aKqi5brY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FVQzUrOENleXJ5U2VhZTg5ZEsxS0xPRFFJMkVKZVpBR1ZBUGhhaHZ2VUNi?=
 =?utf-8?B?WGFqVFdndHFNQndtQ0JNbzBuTG1RSTVkT3BmWjBCaEZlZEZrWm5Takh3TWVD?=
 =?utf-8?B?cUVGRHlWNnRHWXFldVlaMXJMQ25LUWJwRDRjQzVuaStBdXJlQXpxMk5ORUd6?=
 =?utf-8?B?RGxKSFdrUVZoOU92RXZwelNWaHMrSytRd0NRWWUxbXhCcXJRRlk0UlZyUDBF?=
 =?utf-8?B?aEJIZTVKK0YwNDUxYXZWTW9ESUNCck9TUE9xUmVHcUkySTdySlVFVFc5MHpz?=
 =?utf-8?B?aEszMG5Gc2dJSjZqdERYc2p2WVdaUHZrQktaNGpJOW9OdGNXODhCWkNWQlRC?=
 =?utf-8?B?T3BRZk02M0lhcWZneWVaZ2NnSHE4UXNzbmlYUklGMndxNVBhbHdIb0c3VWw5?=
 =?utf-8?B?SXJpU1BUdEtDR2t1UnBpTEJYWE94eDFLOEczZVdWajRlRmdObzZzT3J3OTA2?=
 =?utf-8?B?T2E3VERPS3gzMGFzbnRTVldsVjAyMTN3Y3Z5VnNyV2p4Nmg5ckR3b0IrTjEw?=
 =?utf-8?B?UUZqQzEyN3F3Kzc5dC8xYmErS1Z1SGV0ZTJMcXkweEtNTFBDNlJvRkZjWHpl?=
 =?utf-8?B?dnQ2ME1vSFJLMFFicnVuYmpjSHlHVjQ5Z1h2NGMwZjBBM1BjMHdaRys3TmU2?=
 =?utf-8?B?VEtrMndIMm1DNU5uYk9naVdKNlVCTXo0UFNKNXdZaGhhQUZCd3hzUUtDWHJi?=
 =?utf-8?B?bktlUEdlWlVPMk1aL2dhUUN3OFdwV1dBQ2Q1TW1nN0dVd0pIenlNaHhEY2R1?=
 =?utf-8?B?ZitpMzBlNy9EamRoam1nSVNNUEtJV00rWVAySmRkeklkWGhTNFNJcnJjdFNB?=
 =?utf-8?B?RWlNYWhLVGFNdFgrakVEdHQ2eTFSL3ZWZUZSQ1A1WXlQL3AyVHdha0Q2NWE3?=
 =?utf-8?B?dEh5ZE5FQ3BKZUFWSlhDbm43c0ZQQm9Va2lRQkY5Vy9oRjV5UWhNUHQ3cEZZ?=
 =?utf-8?B?Q21QL1NTMGpFYkdRbTBIalVOWlhRNWRXbDJ2RGVEMkIyajN5eGswNzZuL3Fh?=
 =?utf-8?B?Y0xUVy9XL0JULzZiWWh2RXdtU2tOUllUUGZoUEltVUZycWFiVSs0RmNpaUlE?=
 =?utf-8?B?WElNWVFGL0FpOWQxUkFmQWVmZHErVU5mUTVjSGtreS83Ly80MG9qaENucGdn?=
 =?utf-8?B?bElRbjMyMllOaUxad2JwSW5QQWQ3alB0OENJQzR5VWExMWZjZ3JXUGYybFl1?=
 =?utf-8?B?OUZEcmhMNnA3V0hsbGp6VDNmb3V0blBCbnpnYk1PMFF6SWgzbWhpRFhmYUVy?=
 =?utf-8?B?RHEzWlN4ckdmbEovbDd4a3pHOFFSTjc2SnBkeHk1YXJYSXJyTjFxdkZRMHhn?=
 =?utf-8?B?Zy9iQjBLOHFiKzlFb2FNa3ArT3RhZ1pQcDBXOEVSMDcxZmhPSTZoMnBSYkw5?=
 =?utf-8?B?N2wvVVNWak11dHREMXRMMjFvRlhjQzRqQ2w0Vm96a1IzOEQ4QkFUcUIyeUZ3?=
 =?utf-8?B?MURsQWJ4WmRNbkVUN0hBaTFDT1Z6K0RRSWNWU1ArbnA1eW9RbWdQZTRUN2Zu?=
 =?utf-8?B?SFJ4S3dXY1BXMmFubDdtbjZHT1NVL3BILytkdStYWFlnQTZYaVVoM0h3WkZ5?=
 =?utf-8?B?d2xjcnRhVERSanljMTFZVVRSRU5RYUUvNlEwNXRtUDg4eTl4a2VCRTRraE5m?=
 =?utf-8?B?K2t5UUtHZ3FoL1FteXlIY3RPeTJ4NUllbTQzVENWQkNHQWlNT2N4UFZOV0o1?=
 =?utf-8?B?WGNRRlRKZTRGN2t1WFZOSE1QcnprQS9HRjVpUmwwbHlxYyt5eGp5N3VQY2p3?=
 =?utf-8?B?WGlIQ05IS0l0ZWRQdGlYa04xMTM5SEFpc203ejA4TVJaVDdRVjRWMnJTQzVV?=
 =?utf-8?B?QkVwY3F4bnIvWE5meE43aDE0MjlnRHRaQ3lDazlmYjFzaTczVCtid21TRW5Y?=
 =?utf-8?B?a3JqVWY2SVNoNEZ2MzcrMDVBemczRldkM3BWbS9XNDFOb3R6R1NLbXJxNHBW?=
 =?utf-8?B?bjF6ZmlCWUxyUWFqMExlcUs2WTBwelIrOXEzelJBQjlsSVI2UzkxNVJ1dFJ1?=
 =?utf-8?B?NzBNUUF5a0gzOFo3Qzh1YWhoK25KSUdTRVhQYnFtWFNvdTRPNWdZeUNUZTNs?=
 =?utf-8?B?TjB6cURoU1FMZmMvUTN0TGxGbmY4VlR0dFRjd0xiWGJmNWFLUWVvdnFUeVZi?=
 =?utf-8?Q?334uEvD/XThKzh0HawYV9yzNC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a1ed0-5448-424c-f63d-08dd9ded8809
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 13:42:47.4420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMfin71hxWzbfaXs7ZyUVis5oAVr+LGbgkamsQm9ZJIfdjLdlehcrGXNgJVCMWSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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

On 5/28/25 15:41, Alex Deucher wrote:
> On Wed, May 28, 2025 at 7:45 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/28/25 06:19, Alex Deucher wrote:
>>> We'll want to include the padding in the wptr count
>>> for resets.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 802743efa3b39..3e05e8bfaca4a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -304,6 +304,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>           ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>>>               ring->funcs->emit_wave_limit(ring, false);
>>>
>>> +     amdgpu_ring_pad_to_fetch_size(ring);
>>> +
>>
>> Hui? Why that here? amdgpu_ring_commit will do that anyway.
> 
> So that I can know the full size of the submission frame for this job
> when I grab the follow-on ring contents to re-emit.  See the next
> patch.

Ah! Ok, why not doing that after the ring_commit? Then we don't need to change anything here.

Christian.

> 
> Alex
> 
>>
>>
>>>       amdgpu_ring_ib_end(ring);
>>>       amdgpu_ring_commit(ring);
>>>       return 0;
>>

