Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6223D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 04:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FC010E36B;
	Wed, 10 Dec 2025 04:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ApbD5yzp";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F0E10E36B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 04:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5O6cgKEYb86g60TOrzZ2mEbuXPtdtT1AqHlT6CMwe8RZXEsvRr6MmOul3QxLmUXoG7LBLB8JK/J56+6EVzKjjfolBhR3uvMJcch9CUqkhFC9w9NwqxGP28FaN5ZygyCNc5GmXKRi8SCcmy3quKYiyiAi1wl9b2n0UqzzKYS7lnAzcACuqXEc/164MYm7nFBjW55841RKerai0c2YizgUlU2rhigdME0V+4aw4zTW/WOgE7WTAw4iM3ietYgcEemTUi/0lFPVvH9q0vUb/abphl+9+Rh42pLs3VRyM0G7dsMYustB4jQGfTYVPe0KyMzpdT+CHM5IK5fSjWVraGItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShMqMeCE5l9A+PrOaHuv+cj/xLR0DhpzGgR3vbopX7k=;
 b=uN5XbeD8sqy9mlE8OVB+e72tkiQBh3UETPFFCQnLX9ABh7PCnDie1Z462GfJHxqPCFPdevezCDU/cudkJxTY4x7uZUuavDtSzVfv5L0g7wdxun4apf/JhBRolUkoQihqBMBiHFrwCftEtOk7J6qCyijouDzOfL9HJKphrdCYsXui2JtbD/gp0jMezpWK6GKcny1b2Ft9WgTvp5G9buci6f6qIO2ZrTEdPpqozn3EUfiz5IPXE1BKVngESndWz4hPbOiyd0quip+puX6broIk0q15jBOw5cEEQPG2Tni/n1BiW3M5ehp3p/KbB0FQLQtH5/mILgneHx3Qq1I41DH2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShMqMeCE5l9A+PrOaHuv+cj/xLR0DhpzGgR3vbopX7k=;
 b=ApbD5yzpdvIDeDx+LgpzlZU+5DKs9E6W0Bqq9fpUB0ElSM4yPnJacf4JqH+whdDwc5ZDFgMAVwvju9vl12AmuibcsCZtcmiZyBs8bAEgGuSfIavtvX/W81bY3g4zDS1k7ERU6cupUqQDclJby80nildhPJtIaoB7Z/8HsfK7NYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 04:34:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 04:34:47 +0000
Message-ID: <e5d81888-054d-4d77-b3cd-e72ce54a1dbe@amd.com>
Date: Wed, 10 Dec 2025 10:04:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20251209073831.1426657-1-chongli2@amd.com>
 <4e4a99a9-5fff-42c1-ae5a-b2f925df2633@amd.com>
 <MN0PR12MB5761696F1F3009C6F4EB2F969BA0A@MN0PR12MB5761.namprd12.prod.outlook.com>
 <815a5f79-1eb4-4001-9274-605376744d8a@amd.com>
Content-Language: en-US
In-Reply-To: <815a5f79-1eb4-4001-9274-605376744d8a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0392d3-6bf2-4ba9-f200-08de37a572f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykw0T2ZUNGRyVTlKSlJtUlcyT0dKV0NvMm1RVXpvV1FPaFl0TVVDSk8wQWUw?=
 =?utf-8?B?RnlBbnY0ZjhydldvWHFsS3I0MlBtOEZrbkhCZ3EwVE5Dd0dMamZhV3B0Vk13?=
 =?utf-8?B?SFZQaVJYYzNGOXFBSUVSNE1ZMjU1VDI2Mmt6UDVWTDZqQTl4TTB6aVN4S1Yw?=
 =?utf-8?B?SGF1aVVQRVp0dXJlY2FOOExRWlJhdjVUbnRGbU45Sm1Tc2RTcHQ5OW9hREZR?=
 =?utf-8?B?cDR6SDNDTUUyUHhVclR3V3ozaklmTk0wSUZLVzA2QWpPRnlydHo3T0FHeGxs?=
 =?utf-8?B?ZFUydUc5VWZCOG1CaXFMeFZmS2FlbkVwdlFtVkJid1duU2cwZTk0dEUxSVJX?=
 =?utf-8?B?clAxZGpFMm1YMTdGVCtodzdaVWl0RHZ0ZXM1SUlCTWwzNE9SZ1FySnNwZ08v?=
 =?utf-8?B?ZDZnOGFaYmJBRGlOcVhtMXQ5cFdhZ3pTTkg3OXpoNmQvS21YZ0M1c3BET3pr?=
 =?utf-8?B?aE91KzVMSjFlOGRDQk5yODl0V0V3eEVmWDJMNHBNK2hiVGR5UVp6Rnl4SjNY?=
 =?utf-8?B?aEl6R3F4V0pjN3JSSEhzS2NHYk9KMXh3QzVpL0JydG42T2F1OTZBUEYzVUtX?=
 =?utf-8?B?d3l3WVl1c3FRMFBQS2lVUGVna2d4ck5iYlZ5WnJHWm0xUXFUTUE4akcza2d4?=
 =?utf-8?B?OEtMVUVGYXdEc09nQWUybGNWYURjbXNrbXorVUxyd0VTeU5CUExlYm0vTlJ4?=
 =?utf-8?B?ZzJQNGczNkphclkzQUs1aUZzRkV5NklRQmdCSkdDYy9PMlM0cUZUT2JxR2lC?=
 =?utf-8?B?dDJIZjhGYUFlZXZuNXI4bkMzc3g5dFZ5MWtQTGxJUHpPQURPWlMvY0toUExo?=
 =?utf-8?B?ejNHNEpYK0tEZTJTcHVWMW9sazFtd3NBZ0RNL0ZPb2xqVXVxdU03ZUNzL3M1?=
 =?utf-8?B?emF2VitOb0YvZ2tqWGRnUm9sMkhuTklNTHBpOEM5ZzVDbnpHOHV0OGZmOWVu?=
 =?utf-8?B?YVJtMzNWN1NvZys1MDJzSWtvejFGUHJESlI0UFB3ZUZicmp6L1UwRWxwN3Ri?=
 =?utf-8?B?c3hhZ0RzKzRCbmo2V0RoWmQ5ZkJiQWZmWmZBT3FRcVcvdEY1VjZTY2VSS3hh?=
 =?utf-8?B?R1FrbTZqNlBZNDV2MTRhelNsblJ2TjBVVmIwbHFPL3MrUnZCZ3VtV0lOaEdL?=
 =?utf-8?B?ZXFBKys5d2l6NWJ4OG5TRzY4TWdaSkIwckxsUVRSK2JNbG83bjBJekExbmJC?=
 =?utf-8?B?Uko4QVZPMTFXc3QwTWQvUzRML3kvZ3RhMVpFRnkydnRRQ2xtVGp5eFhxOXdr?=
 =?utf-8?B?eTdCNXNVeTArYzgvQVpCTFNJTll3akk5cnpZTStvY2o0NDRRV3JkckIzMnJE?=
 =?utf-8?B?SFZEajB5V1NnY0RYbEJwNjBRSVJzQmVEVG9meHA0VnVlcVpKOWhIZlE2SER2?=
 =?utf-8?B?Nzc3cE9zbFFGVDMzUnRvMkRvWG0zOWFpZW9uTDZuQnRxT1hSMVhDQXJuaWhO?=
 =?utf-8?B?azhSSmkxSzRpQ0t3cWFqY0FmbHdUei9NZFowR2kwVTJxbDYyelAxOWEzZ3Nn?=
 =?utf-8?B?NGllVjdIaDZEaCtNUFBjc1lhNUwzdmVXSlB2NE9jb0Z6OFJuSjJjcnE2RDIr?=
 =?utf-8?B?UHZoS09CT2cyUDFnUUF3OHpyK29nMnJsUW1OaDNVRitCbE5Zdzlib1NFbS9M?=
 =?utf-8?B?djEzZGgwblZKZWpHeFRsZW9JTGNiUW53cEEyOWZ1SnJQQnVGL3dXT3BZNFBN?=
 =?utf-8?B?QzJrSWZ1dTQvSUIwZ3A1KzdLYnFLNTAveUFmTUpxaldyMGNFdzh6bGsxd2dm?=
 =?utf-8?B?WmYxYkJZdFZ1NG5iYS95MlFZM0xBTDd4b2YwcnF2d0gveGs1NHhrUUNnTllB?=
 =?utf-8?B?YThPakNiVjBiRm5icmN1eEw2bzUrbEQrc1JUeW50WUtMOTlZeEh3UGxxUnda?=
 =?utf-8?B?M0kzLzc4VTRGQ25ZY0dQZTVtWE8zSmhXUFhXZEZkNzdLVHhpcTRPRTcrOVZl?=
 =?utf-8?Q?9Wiiwlib1qvgRXfjceyxY+DaDqU3mwfQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0d0b2tJbk05TmhRbzRCbFZTYXRqRS9MZHcycldQSE1HWUQxN1B5MGdnT0o0?=
 =?utf-8?B?N2R4d0VkWm5pQzNMWWVrcEtkZWZrMXNSL0FtWnJYYzl1QS9kMk9hZEd5TGJn?=
 =?utf-8?B?UVgwVjdFNEdDWks2cTZXRnVOTDlSV1hRbWY3U0FnY0RsSW9VKzMvckJlUVZQ?=
 =?utf-8?B?alJWMWhseW1WRit0ODYxT0FZelgyTmFHN09GN014TER1YkYyaHRkZ3pVYjc4?=
 =?utf-8?B?Qk1sa0dqRG1vVmIrSFBianlYRnlNN25JMFJYbzRhTFhZMEp3WmtRclA2WHUw?=
 =?utf-8?B?bDdzYkFuZEtzNEc4cDBMbnF5Q2tMcFA0NTRvR3Z3VUMzd2lQc1JDNGxsaXhP?=
 =?utf-8?B?Z281TDlxa043OFdjcEpqc2xVNFdlY0hDQlZVYlVZS0tMWFBJMU00bnZyK2VX?=
 =?utf-8?B?cERqTkRpV2QwWDllMGhheFNidjlCV2N0OGJjNS8wb3Byc2UrMm9PWHFCdVcy?=
 =?utf-8?B?YXIvclM2U2VwYkN5ZUlXVnNmQXJWOEZTdGpOVE9ackY1U0FLQzYyL0oveTZm?=
 =?utf-8?B?a2N4dHIwZFZ2d0trQktRNUlDSGt1MC92cW13Szk2aHN5TGl5ZlhJbmtwWnF6?=
 =?utf-8?B?RHRPQWIxbkdDWEpyVjVmM0ZjTVlDbDRMWHRmWU1weWROKzNZVmJUWHRoTURF?=
 =?utf-8?B?ckF0ckNIL2xHSk5FNkt1OFl3Qzd3RlpVZlh1NVI0RTJzVkhYS0l5a2V1c0pw?=
 =?utf-8?B?eUhLa1QveEFWWUIzcHVkVVZJaHdYOGZRaCtOSW5xTU1EMHVkcTJVSkNyQThY?=
 =?utf-8?B?MGo3aG42dTZMem5WRjc3UWxmZlgxOU1lUU5rVTMrTmpNVmxsTE8zNDVKUS9V?=
 =?utf-8?B?N3ZBbTNrdXRmeHNLOSt4RDFHY21LVEdwUzlTKzZmUXE3bUg4bDdxYTBTaTBW?=
 =?utf-8?B?dUxWMi9mRktnR1dvN3p5elVOZzY3ZTk1RVNvV0MreXd0eVhnZWI3aSs3Y3RT?=
 =?utf-8?B?c3pjTzZCdzVZcmJEZHFJNzIrUjlpV0xJVDJHcjRzOWU4aHhQVy9PTitpaGNQ?=
 =?utf-8?B?aGpHTFNQdlJOOFgwSHQ1M0RwTjN2ZGYxT25veU4yTHRnR2wyTG85TnhWUDFI?=
 =?utf-8?B?VTB3a3Jib0VGQm44c0lMZTYzZnF0VVBXL2phMWlVcEpjUXphdXoxd2hwZ0tW?=
 =?utf-8?B?UE4rREJ0VnJyVG9oSjN5TjA5Q0Nuams5S1llbGptS3pKUlFCL2dPYVdGeE00?=
 =?utf-8?B?Q3I3OElpYUhLdjBKWFdPSGFUUmI0aW5pZElUUWFpa1J6eXBTS2xQRzlzQjEz?=
 =?utf-8?B?emVuSzY5MysvQzI2cDlpSzF1SVFLcWtvZlZobVZRRlpEamlhTXhsS2ROZ0pl?=
 =?utf-8?B?UFJiYlF2Q2k0M3RRR1I5Qm5RY3hJdnV6REFWVk5Na2FiTGtaN0dYc1hiWG4y?=
 =?utf-8?B?M1lza1JNc1I3bFZ4VVdoeEdRTllwZWQ3WHVXc0ZDUWxUZHFMWlJaQWJJN0Nm?=
 =?utf-8?B?N1dyTTFDclU0NTlaUldCZjRLRTd6TUlLZWZMcmZTRGZLR0RLc3E4WXdZY0ll?=
 =?utf-8?B?QnRQRUZFWkszbE53dzJIWi9QRmJYaGZFRUZXR2dNRTBVT2ZNRU1BcW1zZDVU?=
 =?utf-8?B?VFJSeFJoaXEzSFBzbWZNYThBZXByNFpOTDFtOUFMbzVLbWFCYTR5R1dQeC9t?=
 =?utf-8?B?bUcvYzFxNGlIQU43YlExaElBaS9oa0NGbzVybkVGNnJMOUtxSEJPd3d6czh4?=
 =?utf-8?B?Z2JXa0g5MlpRaTR5c2oxNWk2THRRRlY5cVV6dmJoU2dUekZTSmlPbldFR3Vu?=
 =?utf-8?B?a2lWR2FWRWVreEg4Q3JJQlgxUEtKWDdocFJhY0FzdXY1K3hidFRVOWZ2VTg3?=
 =?utf-8?B?OWtSSkJxZnVkSjAwa1llTEF6WEozR0I5Rmg3NTlNZHJvV0RyUW9KRmpMWW41?=
 =?utf-8?B?V1JLbVFSTlVDdEdJc2VEUVhNbjg3UGJHUG5pRU95VG51b3gyZmhNNVNubDV4?=
 =?utf-8?B?SlRRUDJ5VGlXdXhhR214RGFETHBXbnZVZHpnOU13OTlPdWRXMFJRYmpmaFpM?=
 =?utf-8?B?amoybUo5dEZXWlpUV1R6QzdSRFhZYkpXY1BkcXN6b0JCcnBNeVpqQnV6ZUNH?=
 =?utf-8?B?R1BhVG5OY0xJOSt0b0RHNlJTODBPbmh4MU9GSER2Z3IvcmNkQWZoSG44SUlq?=
 =?utf-8?Q?m6bb2yhE9CkmZ0bFz60NJif/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0392d3-6bf2-4ba9-f200-08de37a572f8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 04:34:47.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+h65qtBY1KA3IFz2B9G1Bsj9hLUfGNtaaqsA8a6sYQWL7mYZV+1j2CxxgWK4/fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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



On 12/10/2025 9:43 AM, Lazar, Lijo wrote:
> 
> 
> On 12/10/2025 8:32 AM, Li, Chong(Alan) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi, Lijo.
>> -----------------------------------------------------------------------------------------------
>> It appears like gfx v9/9.4.3/10/11/12 all can be kept in some 
>> amdgpu_gfx_get_ref_mask generic helper, then it's not required to 
>> repeat the logic.
>>
>> if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>          ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>          switch (ring->me) {
>>          case 1:
>>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>> ring->pipe;
>>                  break;
>>          case 2:
>>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>> ring->pipe;
>>                  break;
>>          default:
>>                  return;
>>          }
>>          *reg_mem_engine = 0;
>>          return;
>> }
>>
>> if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
>>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>>          *reg_mem_engine = 0;
>> } else {
>>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>>          *reg_mem_engine = 1; /* pfp */
>> }
>> ------------------------------------------------------------------------------
>>
>> In gfx10, the ring->me of kiq is 2, this code can pass.
>> But in gfx11 and gfx12, the ring->me of kiq is 3, so this code logic 
>> does not work.
> 
> Is this about mes kiq? There is a flag to check that as well - adev- 
>  >enable_mes_kiq.
> 

BTW, the idea is to have a unique bit assignment for each engine. If you 
have two pipes using this (ex: mes kiq/mes sched) and assigned the same 
bit, that is a conflict.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>>
>> As the value of ring->me has changed with gfx version,
>> the code logic is not repeat, I suggest keep the origin way to assign 
>> ref_and_mask.
>>
>>
>> I accept your suggestion of add params check, alignment mismatch and 
>> delete the unused variable "usepfp".
>>
>>
>> Thanks,
>> Lijo
>>
>>
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, December 9, 2025 6:03 PM
>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when 
>> flush hdp.
>>
>>
>>
>> On 12/9/2025 1:08 PM, chong li wrote:
>>> v3:
>>> Unify the get_ref_and_mask function in amdgpu_gfx_funcs, to support
>>> both GFX11 and earlier generations
>>>
>>> v2:
>>> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
>>> since this function only assigns the cp entry.
>>>
>>> v1:
>>> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
>>>
>>> use function get_ref_and_mask to assign the cp entry.
>>> reassign mes to use cp8 instead.
>>>
>>> Signed-off-by: chong li <chongli2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 54 +++++++++++++++--------
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 ++++++++++++++++ 
>>> +--------
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 ++++++++++++++++ 
>>> +--------
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 55 +++++++++++++++--------
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 55 +++++++++++++++--------
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 54 +++++++++++++++--------
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 54 +++++++++++++++--------
>>>    9 files changed, 275 insertions(+), 128 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index efd61a1ccc66..090714127cba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>>>                                     int num_xccs_per_xcp);
>>>        int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int 
>>> ih_node);
>>>        int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
>>> +     void (*get_ref_and_mask)(struct amdgpu_ring *ring,
>>> +                             uint32_t *ref_and_mask, uint32_t 
>>> *reg_mem_engine);
>>>    };
>>>
>>>    struct sq_work {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 895b841b9626..5c7724f203d0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct
>>> amdgpu_device *adev,
>>>
>>>    int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>>>    {
>>> -     uint32_t hdp_flush_req_offset, hdp_flush_done_offset, 
>>> ref_and_mask;
>>> +     uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
>>> +     struct amdgpu_ring *mes_ring;
>>> +     uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>>>
>>> +     if (!adev->gfx.funcs->get_ref_and_mask) {
>>> +             dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     mes_ring = &adev->mes.ring[0];
>>>        hdp_flush_req_offset = adev->nbio.funcs- 
>>> >get_hdp_flush_req_offset(adev);
>>>        hdp_flush_done_offset = adev->nbio.funcs- 
>>> >get_hdp_flush_done_offset(adev);
>>> -     ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
>>> +
>>> +     adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>
>>>        return amdgpu_mes_reg_write_reg_wait(adev, 
>>> hdp_flush_req_offset, hdp_flush_done_offset,
>>>                                             ref_and_mask, 
>>> ref_and_mask, 0); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index aaed24f7e716..ed79ceafc57b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -4566,6 +4566,40 @@ static void 
>>> gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
>>>                WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
>>>    }
>>>
>>> +/**
>>> + * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> +adev->nbio.hdp_flush_reg;
>>> +
>>
>> Need to do NULL check of params (this and others).
>>
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 
>>> << ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring- 
>>> >pipe;
>>> +             *reg_mem_engine = 1; /* pfp */
>>> +     }
>>> +}
>>> +
>>>    static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>>>        .get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
>>>        .select_se_sh = &gfx_v10_0_select_se_sh, @@ -4575,6 +4609,7 @@
>>> static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>>>        .select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
>>>        .init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
>>>        .update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
>>> +     .get_ref_and_mask = &gfx_v10_0_get_ref_and_mask,
>>>    };
>>>
>>>    static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev) @@
>>> -8614,25 +8649,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct 
>>> amdgpu_ring *ring)
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 ref_and_mask, reg_mem_engine;
>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev- 
>>> >nbio.hdp_flush_reg;
>>> -
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -             reg_mem_engine = 0;
>>> -     } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring- 
>>> >pipe;
>>> -             reg_mem_engine = 1; /* pfp */
>>> -     }
>>>
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>        gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                               adev->nbio.funcs- 
>>> >get_hdp_flush_req_offset(adev),
>>>                               adev->nbio.funcs- 
>>> >get_hdp_flush_done_offset(adev),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index f4d4dd5dd07b..c3d8e7588740 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -1072,6 +1072,44 @@ static int 
>>> gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>>>        }
>>>    }
>>>
>>> +/**
>>> + * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> +adev->nbio.hdp_flush_reg;
>>> +
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 3:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 
>>> << ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring- 
>>> >pipe;
>>> +             *reg_mem_engine = 1; /* pfp */
>>> +     }
>>> +}
>>> +
>>>    static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>>>        .get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
>>>        .select_se_sh = &gfx_v11_0_select_se_sh, @@ -1081,6 +1119,7 @@
>>> static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>>>        .select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>>>        .update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
>>>        .get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
>>> +     .get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
>>>    };
>>>
>>>    static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev) @@
>>> -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct 
>>> amdgpu_ring *ring)
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 ref_and_mask, reg_mem_engine;
>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev- 
>>> >nbio.hdp_flush_reg;
>>> -
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -             reg_mem_engine = 0;
>>> -     } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring- 
>>> >pipe;
>>> -             reg_mem_engine = 1; /* pfp */
>>> -     }
>>>
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>        gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                               adev->nbio.funcs- 
>>> >get_hdp_flush_req_offset(adev),
>>>                               adev->nbio.funcs- 
>>> >get_hdp_flush_done_offset(adev),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index f9cae6666697..b805ed4f88aa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct 
>>> amdgpu_device *adev,
>>>        return -EINVAL;
>>>    }
>>>
>>> +/**
>>> + * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> +adev->nbio.hdp_flush_reg;
>>> +
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 3:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 
>>> << ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>> +             *reg_mem_engine = 1; /* pfp */
>>> +     }
>>> +}
>>> +
>>>    static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>>>        .get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
>>>        .select_se_sh = &gfx_v12_0_select_se_sh, @@ -938,6 +976,7 @@ 
>>> static
>>> const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>>>        .select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>>>        .update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
>>>        .get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
>>> +     .get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
>>>    };
>>>
>>>    static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev) @@
>>> -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct 
>>> amdgpu_ring *ring)
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 ref_and_mask, reg_mem_engine;
>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev- 
>>> >nbio.hdp_flush_reg;
>>> -
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -             reg_mem_engine = 0;
>>> -     } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>> -             reg_mem_engine = 1; /* pfp */
>>> -     }
>>>
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>        gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                               adev->nbio.funcs- 
>>> >get_hdp_flush_req_offset(adev),
>>>                               adev->nbio.funcs- 
>>> >get_hdp_flush_done_offset(adev),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> index 66a4e4998106..b3ea45e3c60f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -2068,23 +2068,10 @@ static int gfx_v7_0_ring_test_ring(struct 
>>> amdgpu_ring *ring)
>>>    static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>    {
>>>        u32 ref_and_mask;
>>> -     int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 
>>> 0 : 1;
>>> -
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -     } else {
>>> -             ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>> -     }
>>> +     int usepfp;
>>> +     struct amdgpu_device *adev = ring->adev;
>>>
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
>>>        amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>>>        amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, 
>>> wait, write */
>>>                                 WAIT_REG_MEM_FUNCTION(3) |  /* == */ 
>>> @@ -4075,12 +4062,46 @@
>>> static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
>>>        cik_srbm_select(adev, me, pipe, q, vm);
>>>    }
>>>
>>> +/**
>>> + * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 
>>> 0 : 1;
>>
>> This doesn't look used inside this function.
>>
>>> +
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << 
>>> ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << 
>>> ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>> +             *reg_mem_engine = 1;
>>> +     }
>>> +}
>>> +
>>>    static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
>>>        .get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
>>>        .select_se_sh = &gfx_v7_0_select_se_sh,
>>>        .read_wave_data = &gfx_v7_0_read_wave_data,
>>>        .read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
>>> -     .select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
>>> +     .select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
>>> +     .get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
>>>    };
>>>
>>>    static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = { diff
>>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index 5d6e8e0601cb..cc5acfcdf360 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -5211,13 +5211,46 @@ static void gfx_v8_0_read_wave_sgprs(struct 
>>> amdgpu_device *adev, uint32_t xcc_id
>>>                start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
>>>    }
>>>
>>> +/**
>>> + * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +
>>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << 
>>> ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << 
>>> ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>> +             *reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
>>> +     }
>>> +}
>>>
>>>    static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
>>>        .get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
>>>        .select_se_sh = &gfx_v8_0_select_se_sh,
>>>        .read_wave_data = &gfx_v8_0_read_wave_data,
>>>        .read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
>>> -     .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
>>> +     .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
>>> +     .get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
>>>    };
>>>
>>>    static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block) @@
>>> -6000,25 +6033,9 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct 
>>> amdgpu_ring *ring)
>>>    static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>    {
>>>        u32 ref_and_mask, reg_mem_engine;
>>> +     struct amdgpu_device *adev = ring->adev;
>>>
>>> -     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>> -         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -             reg_mem_engine = 0;
>>> -     } else {
>>> -             ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>> -             reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
>>> -     }
>>> -
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>        amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>>>        amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, 
>>> wait, write */
>>>                                 WAIT_REG_MEM_FUNCTION(3) |  /* == */ 
>>> diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index e6187be27385..f2ebacc73eb2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -1997,6 +1997,40 @@ static void gfx_v9_0_select_me_pipe_q(struct 
>>> amdgpu_device *adev,
>>>        soc15_grbm_select(adev, me, pipe, q, vm, 0);
>>>    }
>>>
>>> +/**
>>> + * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> +adev->nbio.hdp_flush_reg;
>>> +
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 
>>> << ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring- 
>>> >pipe;
>>> +             *reg_mem_engine = 1; /* pfp */
>>> +     }
>>> +}
>>> +
>>>    static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>>>            .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
>>>            .select_se_sh = &gfx_v9_0_select_se_sh, @@ -2004,6 +2038,7
>>> @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>>>            .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
>>>            .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
>>>            .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
>>> +             .get_ref_and_mask = &gfx_v9_0_get_ref_and_mask,
>>
>> Alignment mismatch?
>>
>>>    };
>>>
>>>    const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = { @@
>>> -5380,25 +5415,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct 
>>> amdgpu_ring *ring)
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 ref_and_mask, reg_mem_engine;
>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev- 
>>> >nbio.hdp_flush_reg;
>>> -
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -             reg_mem_engine = 0;
>>> -     } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>> -             reg_mem_engine = 1; /* pfp */
>>> -     }
>>>
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>        gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                              adev->nbio.funcs- 
>>> >get_hdp_flush_req_offset(adev),
>>>                              adev->nbio.funcs- 
>>> >get_hdp_flush_done_offset(adev),
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index 89253df5ffc8..b4ba76110c34 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -838,6 +838,40 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct 
>>> amdgpu_device *adev, int ih_node)
>>>        return xcc - 1;
>>>    }
>>>
>>> +/**
>>> + * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP
>>> +flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring 
>>> type and me.
>>> + */
>>> +static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask, 
>>> uint32_t *reg_mem_engine) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> +adev->nbio.hdp_flush_reg;
>>> +
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>> +             switch (ring->me) {
>>> +             case 1:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 
>>> << ring->pipe;
>>> +                     break;
>>> +             case 2:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 
>>> << ring->pipe;
>>> +                     break;
>>> +             default:
>>> +                     return;
>>> +             }
>>> +             *reg_mem_engine = 0;
>>> +     } else {
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring- 
>>> >pipe;
>>> +             *reg_mem_engine = 1; /* pfp */
>>> +     }
>>> +}
>>> +
>>>    static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>>>        .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
>>>        .select_se_sh = &gfx_v9_4_3_xcc_select_se_sh, @@ -848,6 +882,7 @@
>>> static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>>>        .switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
>>>        .ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
>>>        .get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
>>> +     .get_ref_and_mask = &gfx_v9_4_3_get_ref_and_mask,
>>>    };
>>>
>>>    static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle, @@
>>> -2818,25 +2853,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct 
>>> amdgpu_ring *ring)
>>>    {
>>>        struct amdgpu_device *adev = ring->adev;
>>>        u32 ref_and_mask, reg_mem_engine;
>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev- 
>>> >nbio.hdp_flush_reg;
>>> -
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> -             switch (ring->me) {
>>> -             case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>>> ring->pipe;
>>> -                     break;
>>> -             case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>>> ring->pipe;
>>> -                     break;
>>> -             default:
>>> -                     return;
>>> -             }
>>> -             reg_mem_engine = 0;
>>> -     } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>> -             reg_mem_engine = 1; /* pfp */
>>> -     }
>>>
>>
>> It appears like gfx v9/9.4.3/10/11/12 all can be kept in some 
>> amdgpu_gfx_get_ref_mask generic helper, then it's not required to 
>> repeat the logic.
>>
>> if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>          ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>          switch (ring->me) {
>>          case 1:
>>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << 
>> ring->pipe;
>>                  break;
>>          case 2:
>>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << 
>> ring->pipe;
>>                  break;
>>          default:
>>                  return;
>>          }
>>          *reg_mem_engine = 0;
>>          return;
>> }
>>
>> if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
>>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>>          *reg_mem_engine = 0;
>> } else {
>>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>>          *reg_mem_engine = 1; /* pfp */
>> }
>>
>>
>> Thanks,
>> Lijo
>>
>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>        gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                              adev->nbio.funcs- 
>>> >get_hdp_flush_req_offset(adev),
>>>                              adev->nbio.funcs- 
>>> >get_hdp_flush_done_offset(adev),
>>
> 

