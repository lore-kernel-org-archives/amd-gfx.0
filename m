Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14F5CAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 13:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8D110E236;
	Mon, 29 Sep 2025 13:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tBFW/9XF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F053010E41E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 13:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpMb9K7iv051R14Tfchb1i86JdTBMHr7c+Tw8XZnRG0X1Jho7zhHETYo/7+OJEBWzOtYR0nlWfHARtLhwrd/Qt08Rqic4ZIgxDzBYyxciBQzFSSbtgbVYePy7GKtl62fNxUuptSY+AjXwd6ltkPQeQBx0eK37N+j7lf4Ty3NnBoufIeIA+8PknGx0JoL6FFjb6AsuLZn+9S8noy5FwdIDFfkG0iOnRMqT9U7l7aPLL7ZkAEFSS3Zg6VHlobwRbEsWK+lTARElj+J4XyMj+cRuv8Ta+nb6jWn4fBMt4jadBgOAs1/mZyCgoq/tiKPTeuwAlbsOqyLHP/naIlrF+Wvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnVjQgcu9f0GjF2PVn8LsFTNon7J9gSga3W4LYhy9jM=;
 b=r8bzNjJvviui6iYRo+koU4c2StUZxQPQY15UZfKFR4o0FETy1mzIlikPKMWoSnaGnsk5dKMLnNulHYwwWpNNPlXwG6JdRPjXFRpWHYg+VTRlhT937QQa+u0YdeoMKBrFClcZhFMC6Uhza547FfuZetPXdhdBZ8pl2lj3IhnGXvM6KKqyf9PrdcSnYX71m/ans6U6NYWMgbRUY2KFaknYPPRltcJwQ+cEsM9a59XQYXv4EvgrPVOmd3biaDu+uNQimPWajgaXN5CURKpDn3HyR+ZCkHfCi7fR+sohopVD1E/yF5zoQlWZ/AFQ4Se8y2wT09+UARiOUBDxqSE6H55j/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnVjQgcu9f0GjF2PVn8LsFTNon7J9gSga3W4LYhy9jM=;
 b=tBFW/9XFmqR5sYg1AFXa2QPT0ybKuH9zq2SopdkySNgvkTBu65Gcyy0IJ6DQo8a7b1tuzBOn8grqkzKjLejQXFZt5hP0Sz9BGzVD929cK0sJreV0292xRYaBS226rkOD5uHKDC4U+JFIpFJgwXnZ2fmSzoM0DJ2etoffiHpKt+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:09:35 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:09:34 +0000
Message-ID: <ffe77d32-3aee-9467-306e-5c8d4a3404b6@amd.com>
Date: Mon, 29 Sep 2025 09:09:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] amd/amdkfd: enhance kfd process check in switch
 partition
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 Lijo.Lazar@amd.com
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <20250924152929.2234747-2-yifan1.zhang@amd.com>
 <67559487-9a4b-4224-b627-1d7f2784136c@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <67559487-9a4b-4224-b627-1d7f2784136c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b9a51b-1db8-43a0-391e-08ddff596f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2tkZG1xdGhBeUNZTnZmUkhwdXBPWTB2cFhEVndaM2x0clA2dTBCdnJhL1hD?=
 =?utf-8?B?TlpuL0o5ampiYyt5OENFWXRMT3NNRW11S0NWaFNlSVFESHVBQmNMM01rNTc5?=
 =?utf-8?B?Sm5kOVFRWmtxK2dmWWJ6WFpPVUszTUw0dUpPWFJsb1NEajVEcHp1ck1Ca2ZJ?=
 =?utf-8?B?NWg2MmtCek1vRWsrWjZqMkhEYXVRbDRHZUUrMnMyOFhkdnUyRTJSR2FFdFNO?=
 =?utf-8?B?TmRGcnh1MU0yTk95Z3BzdmVQSldNelVVRWFkOFVEeUpVWTRwcGtpZ3dpWHIz?=
 =?utf-8?B?SjdsNzBzaVhHdWJhWlI3aElGc2RYQzBXaXQ0bHYrSEtxRy93NHhISGJKbWtr?=
 =?utf-8?B?aFlhalRwZjYyR1Bmdk9UZEFmcVFYd1gxb1VjUnRmRG8xbjA1NUtVTFJlVVNw?=
 =?utf-8?B?U041eXRELzlCNnRUMDVmMnVEdnVPeUljU1hyUWEzQmpuRUFHWm5kRFhWb2ww?=
 =?utf-8?B?REJPcUo2VndMVlVyR21WencwVGE0VzlENU9jM3Z1c3VoZzhHL0l2c2xLUzJO?=
 =?utf-8?B?V05ub21Xd0p3WHRoK0l2cmU2R0JTV0FSbWo5SDJKR2dnanlxR0xRY1FLV2do?=
 =?utf-8?B?R1p0WGdmYkQ3ek9QUHArMHIvODBxS0N3Y3dybmt1QTNzSW9sNGRPTlkrM1Fs?=
 =?utf-8?B?VkJWYWdiR0VNdWFOcXlpdFM4WGQ0NWp2Qk5GeVdZcVQ3VzFYWnpuaFNNWXpL?=
 =?utf-8?B?TUxrOHFPa0xPekg2QzI0TnZQNEFXcXRiK0NmYlRzNmZoU2w2NUxsRnF0TmVi?=
 =?utf-8?B?THMrVjFWNWZ5cXBwOXNkazk0UGhaMU9lN0hPdXc1Qk5ub2pqQW9uc29uQ0dJ?=
 =?utf-8?B?Rm9TYzFSdHNVSlR4Mk1mNEhCdWk2ZkVXcDRiNis4NHdQc0tUcVFKeEJsWmQ2?=
 =?utf-8?B?N1crcWtEclV6QXJGd2NyL040bXBKaThrZzZHelNqemVucnN2Y0pES2xBRyt5?=
 =?utf-8?B?azB5aVdyRDRMUkMrczBpVEJHbDJ5YVNsSFZUV3NIUTVMY2hPWmMvT044R28v?=
 =?utf-8?B?bEFNT2hoSjQyRk5uVWhGUit2Nk9seTJZWTNQTTBXY0xQSk5pV09iVmp4c1JK?=
 =?utf-8?B?SXZIL1czM1FDVWtxemRBZzZ1cUdzVDA4S1cwMEVnRm9rNkFBUkVQYWRsQWZO?=
 =?utf-8?B?ZzVsRjBwV1V4d3NmSjQzeUtYaTN3RmtMZTF5Y2N0UkxiaXNPNGN2WW93bFBw?=
 =?utf-8?B?MWlkVjdCUlByalFCcmNoSStzYUFjZDJIVDRSZ0VDTkFqRmJ1MEtYY3NYUGxl?=
 =?utf-8?B?WEl3TDVBTFovVzA0SisrMUF3aktYUzBSZkduL2svaDJTamxkTHJhUXRsM2N6?=
 =?utf-8?B?UXc0VnpCazRYYll6ODZwRTYzMURZNjIvSEgwN0xpMDc1YkcrWWNJOStXb0pE?=
 =?utf-8?B?VXpuUTVtUnMydEpLOUg3Q3F1T01DekxUSU45MmEyOEtJdVlMbW8wSUswZW55?=
 =?utf-8?B?aXZoME9SM2paYmtLTHJqSVRQSEJpY0c1Y1RzRk5MZDYxNmxmT1NOWmk3cmx1?=
 =?utf-8?B?QkVpSS9kVVE0M0FVTUFURDc4VnNPUHcyVzkybmJJRDdja2ROSG9LcHJlc3NN?=
 =?utf-8?B?RTZhdGRkOXM2RWRaNVlvbVJtOUxUVVFVVUVUeHBuQW5RUFMrQnYzZmNLZ1Rp?=
 =?utf-8?B?QjlDcjhTblUwaTYzdW1mL1JkRkg3RFllTDBTZzhRbHVjNytZeHQ3STd2d3o1?=
 =?utf-8?B?TDluVXpDY0VOOHJ6SEdqa3gwU2QvZUJUZUJLOXRjc0xFN2NzMDc0bndVT3Iw?=
 =?utf-8?B?cW9wdjc4Rkd1U2cyYm85R0lHM3BTSlRXMjJmaXd4UlFJUmE1ZXRwYTdRQTFm?=
 =?utf-8?B?SDlQbVlwM2hzQ3NUdDBoV0ozSUZLSFF4SUNVRFVaaDd5ZjVaOWdnNzZzRzRM?=
 =?utf-8?B?QXplY1U4ZVYvTGMvN0dEeWJEcXdQcWpyNnFGdUZ5a1Q1THd1d0Rrekc1MW5q?=
 =?utf-8?Q?BMM/A+EhJiZmIMmrUoUUUr9ZoryKSva7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjkzekdXUHdqcFNlZEJnSHNKdE9jY3pMWUhzRWxEWDhjR1hjTkg5WExwK1dm?=
 =?utf-8?B?U1ZtKzJJS0J2cHRtWDRkYkIrL0tPNnNaQ0VKa3RlRHlCcG1tSDJKSm5KRmZR?=
 =?utf-8?B?NDFYd0VyZSt6NWVHcDJWcHZCVUVqcVVzeG9XdForV0dQd25aQStpemV2T1BP?=
 =?utf-8?B?NkhjdkxlbFZoSUZla3NPOUk3Qm5ua29qVCt4V1J5WVpuYlg1dUZIYWFTakRa?=
 =?utf-8?B?VXVCNS9uUG1jSko1Q0NCSHdiOTJSQU5kQlN1a1A1Z0o4MXJuU2c5Vks2SDUz?=
 =?utf-8?B?eDJGc0M5UEpiN21CNkJ1cUJ2NkVvYWNDQ25nQXd0TmtMSHJrcEZraTdxWDZa?=
 =?utf-8?B?Z2VCNVJ2TG9lVzJZRDZ6eXozUGg0OVdQcnk2Skl4VmtpMms5R29XNkpTdU14?=
 =?utf-8?B?ZmFnQVJMNzRqK05yODBoRkwzQ0lxUXpVRnB6Z0s1VE5pcmlzb1BRK1dYMFZT?=
 =?utf-8?B?RmdLcTRDVmVscEprMVJIekl1OVhwUExTMDRRV3BEbnJvQ2t5cEJQc3RGV2x5?=
 =?utf-8?B?Yit6TXdtODJvVXZsN0lIK2tqOURBSUIzNzFPT2NLVDNqUXdhazFDYU5kWWFM?=
 =?utf-8?B?cW9EWTBNcGdWVTN0dWNoOXJsQ242L3JuV2RTVUhITkhqWlJ5OUl1TUpnWlUv?=
 =?utf-8?B?TEEzNWtMR0JvOXM2NVMvdlAvUC9lYTVGaGRwb3NEb0I0dXdsVFlUemRVSUdz?=
 =?utf-8?B?TEEyN1VhUjQyeThUV2xXNFNZaU5lSVBtNEtiS2c3U0pvSFRxb3dRKzk2T1Vk?=
 =?utf-8?B?SmZrcGhSWG41cUN5TG14SURSY0F4d1hTd3NEckhxRkVyWnhsVFpBZ1dzcmEz?=
 =?utf-8?B?RU9MT1ZRU0VHZVU3TG5leGJUdk4vNE1UcExtdzJrZVVaaVFidy9NNmFGVGw1?=
 =?utf-8?B?SU12ZzBZVzhmOWd0ZzFOOGFnaVZ6bGg0UzJuRjNuUm9lV2dRb05Od3IrcERZ?=
 =?utf-8?B?a0xjbXBWODhaZUdLMnJKYkpQYW8rdC9BYnhZY3J2NjJhd0U4b1BQQjZvNjUv?=
 =?utf-8?B?K09PbkZYUU9DTEw5amFWbmF4VW1pMlhyOUlsSTRFM3o2SkpYZGw2U1UvdnJ3?=
 =?utf-8?B?cTJETXFpa1VIWVFQYzF3dWRJU2xyZDErNk9Ccm8vakQ4c2huNlRsV1FGMzhz?=
 =?utf-8?B?WVQzYVRQdzBybWZkNW5OMjhIMUNPZnZSTXcrZFhlQWYzRXFSanM4bDl4WUVU?=
 =?utf-8?B?V0c1TXJiektRdVVBb0FDak1Ra2JVbTFkVkpIZkVEc1RyWXZhcjEvODRlQTJJ?=
 =?utf-8?B?WTFhaEtOT2VJREdVVFUrNGdCZXZWOStjZlErZU9IOERXdjBPYVRHRUVNS1Vy?=
 =?utf-8?B?ZE9USis5azF6SlNYa3NhK1VjSEtmN3ZzTXZxeDlpS3QvL3grRnk2cVE1NUI1?=
 =?utf-8?B?dDR3cDRvc3pUREVDbEdqbFFzaENBMnF6bFRMWCswa3MyRkQ4bDdjbUJjNjhi?=
 =?utf-8?B?QzZFTHR3aFdqTkFtQXkyWGdoSndCb0ZtcHA1bHYvRlFOUWo5dHAzTTQ4SHMy?=
 =?utf-8?B?RGpKQUFjeGo3UFpMNERKNWxZazQyaFZGS1RZakdFVjE0S1E4b1MxcENGYlk4?=
 =?utf-8?B?NXlnb3FuWkZUbm4zeVBDSkgrVkNMVWdSNG9KQUhEZnk5bXRORnRKcmlMZWNi?=
 =?utf-8?B?UDBudS9ibEx3VlUyWkM0SDlCcDd1ODEvNkNZMkt0TmtYVXkzS2RERUJUeWJh?=
 =?utf-8?B?eWtSamVpZnF2dkxHRzNkdkVBWlMvUjhsSFJXa2JUNzd6MTcra292c3hEamV2?=
 =?utf-8?B?RmZ2SElkMkZ0dDc1YU1HWDl5Zzk5MmR4UUhlbFVtVnpxZTBhbTBSN1BTUDBQ?=
 =?utf-8?B?UDZlOXEvbDYyYzdCVi9BQmNpRXY4c0xFNmQ0SlJ2Ukg5Rkp2S3ZrdTN5MCtN?=
 =?utf-8?B?Y1Nza2hMN1ZzRWUwTS9aU2p0VldxaGgwMy9YSkJKRzFXVk5idEpZUE4wR25Q?=
 =?utf-8?B?N1lUSWZodXpOTUsyQVpyaWtOby9xN2xnTHhSOThja0lrbm9KWWY3ellEVERx?=
 =?utf-8?B?RGs0MUUrWW54dVlHckxKODg1bjJhZGlMUFBaZlB1WnYzSVFJSndPZmZXM2pK?=
 =?utf-8?B?REp6SStueURMejB6WHhTSExDQm1hOEhwOHoyQ0ppZGxlbXpiZmluNDIrZC9N?=
 =?utf-8?Q?h1Jk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b9a51b-1db8-43a0-391e-08ddff596f52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:09:34.3193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxIw9z+Gsya9f3Vg/1DvocSBTA3rYdTr11qe2Sn8m8u45pEty0MFzPlUptVRrsVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
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


On 2025-09-26 15:52, Chen, Xiaogang wrote:
>
> On 9/24/2025 10:29 AM, Yifan Zhang wrote:
>> current switch partition only check if kfd_processes_table is empty.
>> kfd_prcesses_table entry is deleted in kfd_process_notifier_release, but
>> kfd_process tear down is in kfd_process_wq_release.
>>
>> consider two processes:
>>
>> Process A (workqueue) -> kfd_process_wq_release -> Access kfd_node 
>> member
>> Process B switch partition -> amdgpu_xcp_pre_partition_switch -> 
>> amdgpu_amdkfd_device_fini_sw
>> -> kfd_node tear down.
>>
>> Process A and B may trigger a race as shown in dmesg log.
>>
>> This patch is to resolve the race by adding an atomic kfd_process 
>> counter
>> kfd_processes_count, it increment as create kfd process, decrement as
>> finish kfd_process_wq_release.
>>
>> v2: Put kfd_processes_count per kfd_dev, move decrement to 
>> kfd_process_destroy_pdds
>> and bug fix. (Philip Yang)
>>
>> [3966658.307702] divide error: 0000 [#1] SMP NOPTI
>> [3966658.350818]  i10nm_edac
>> [3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: 
>> loaded Tainted
>> [3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_release 
>> [amdgpu]
>> [3966658.362839]  nfit
>> [3966658.366457] RIP: 0010:kfd_get_num_sdma_engines+0x17/0x40 [amdgpu]
>> [3966658.366460] Code: 00 00 e9 ac 81 02 00 66 66 2e 0f 1f 84 00 00 
>> 00 00 00 90 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 00 00 8b 81 58 
>> 26 03 00 99 <f7> be b8 01 00 00 80 b9 70 2e 00 00 00 74 0b 83 f8 02 
>> ba 02 00 00
>> [3966658.380967]  x86_pkg_temp_thermal
>> [3966658.391529] RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246
>> [3966658.391531] RAX: 0000000000000008 RBX: ffff8974e593b800 RCX: 
>> ffff888645900000
>> [3966658.391531] RDX: 0000000000000000 RSI: ffff888129154400 RDI: 
>> ffff888129151c00
>> [3966658.391532] RBP: ffff8883ad79d400 R08: 0000000000000000 R09: 
>> ffff8890d2750af4
>> [3966658.391532] R10: 0000000000000018 R11: 0000000000000018 R12: 
>> 0000000000000000
>> [3966658.391533] R13: ffff8883ad79d400 R14: ffffe87ff662ba00 R15: 
>> ffff8974e593b800
>> [3966658.391533] FS:  0000000000000000(0000) 
>> GS:ffff88fe7f600000(0000) knlGS:0000000000000000
>> [3966658.391534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [3966658.391534] CR2: 0000000000d71000 CR3: 000000dd0e970004 CR4: 
>> 0000000002770ee0
>> [3966658.391535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [3966658.391535] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
>> 0000000000000400
>> [3966658.391536] PKRU: 55555554
>> [3966658.391536] Call Trace:
>> [3966658.391674]  deallocate_sdma_queue+0x38/0xa0 [amdgpu]
>> [3966658.391762]  process_termination_cpsch+0x1ed/0x480 [amdgpu]
>> [3966658.399754]  intel_powerclamp
>> [3966658.402831]  kfd_process_dequeue_from_all_devices+0x5b/0xc0 
>> [amdgpu]
>> [3966658.402908]  kfd_process_wq_release+0x1a/0x1a0 [amdgpu]
>> [3966658.410516]  coretemp
>> [3966658.434016]  process_one_work+0x1ad/0x380
>> [3966658.434021]  worker_thread+0x49/0x310
>> [3966658.438963]  kvm_intel
>> [3966658.446041]  ? process_one_work+0x380/0x380
>> [3966658.446045]  kthread+0x118/0x140
>> [3966658.446047]  ? __kthread_bind_mask+0x60/0x60
>> [3966658.446050]  ret_from_fork+0x1f/0x30
>> [3966658.446053] Modules linked in: kpatch_20765354(OEK)
>> [3966658.455310]  kvm
>> [3966658.464534]  mptcp_diag xsk_diag raw_diag unix_diag 
>> af_packet_diag netlink_diag udp_diag act_pedit act_mirred act_vlan 
>> cls_flower kpatch_21951273(OEK) kpatch_18424469(OEK) 
>> kpatch_19749756(OEK)
>> [3966658.473462]  idxd_mdev
>> [3966658.482306]  kpatch_17971294(OEK) sch_ingress xt_conntrack 
>> amdgpu(OE) amdxcp(OE) amddrm_buddy(OE) amd_sched(OE) amdttm(OE) 
>> amdkcl(OE) intel_ifs iptable_mangle tcm_loop target_core_pscsi 
>> tcp_diag target_core_file inet_diag target_core_iblock 
>> target_core_user target_core_mod coldpgs kpatch_18383292(OEK) 
>> ip6table_nat ip6table_filter ip6_tables ip_set_hash_ipportip 
>> ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_port 
>> xt_comment iptable_nat nf_nat iptable_filter ip_tables ip_set 
>> ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 
>> nf_defrag_ipv4 sn_core_odd(OE) i40e overlay binfmt_misc tun 
>> bonding(OE) aisqos(OE) aisqos_hotfixes(OE) rfkill uio_pci_generic uio 
>> cuse fuse nf_tables nfnetlink intel_rapl_msr intel_rapl_common 
>> intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit 
>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm idxd_mdev
>> [3966658.491237]  vfio_pci
>> [3966658.501196]  vfio_pci vfio_virqfd mdev vfio_iommu_type1 vfio 
>> iax_crypto intel_pmt_telemetry iTCO_wdt intel_pmt_class 
>> iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul 
>> ghash_clmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg 
>> snd_hda_codec snd_hda_core snd_hwdep snd_seq
>> [3966658.508537]  vfio_virqfd
>> [3966658.517569]  snd_seq_device ipmi_ssif isst_if_mbox_pci 
>> isst_if_mmio pcspkr snd_pcm idxd intel_uncore ses isst_if_common 
>> intel_vsec idxd_bus enclosure snd_timer mei_me snd i2c_i801 i2c_smbus 
>> mei i2c_ismt soundcore joydev acpi_ipmi ipmi_si ipmi_devintf 
>> ipmi_msghandler acpi_power_meter acpi_pad vfat fat
>> [3966658.526851]  mdev
>> [3966658.536096]  nfsd auth_rpcgss nfs_acl lockd grace slb_vtoa(OE) 
>> sunrpc dm_mod hookers mlx5_ib(OE) ast i2c_algo_bit drm_vram_helper 
>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops 
>> drm_ttm_helper ttm mlx5_core(OE) mlxfw(OE)
>> [3966658.540381]  vfio_iommu_type1
>> [3966658.544341]  nvme mpt3sas tls drm nvme_core pci_hyperv_intf 
>> raid_class psample libcrc32c crc32c_intel mlxdevm(OE) i2c_core
>> [3966658.551254]  vfio
>> [3966658.558742]  scsi_transport_sas wmi pinctrl_emmitsburg sd_mod 
>> t10_pi sg ahci libahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) 
>> iw_cm(OE) ib_cm(OE) ib_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE)
>> [3966658.563004]  iax_crypto
>> [3966658.570988]  [last unloaded: diagnose]
>> [3966658.571027] ---[ end trace cc9dbb180f9ae537 ]---
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 9 +++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 051a00152b08..488c8c0e6ccd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -1493,6 +1493,15 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev 
>> *kfd)
>>         mutex_lock(&kfd_processes_mutex);
>>   +    /* kfd_processes_count is per kfd_dev, return -EBUSY without
>> +     * further check
>> +     */
>> +    if (!!atomic_read(&kfd->kfd_processes_count)) {
>> +        pr_debug("process_wq_release not finished\n");
>> +        r = -EBUSY;
>> +        goto out;
>> +    }
>> +
>>       if (hash_empty(kfd_processes_table) && !kfd_is_locked(kfd))
>>           goto out;
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index d01ef5ac0766..70ef051511bb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -382,6 +382,8 @@ struct kfd_dev {
>>         /* for dynamic partitioning */
>>       int kfd_dev_lock;
>> +
>> +    atomic_t kfd_processes_count;
>
> Why need add kfd process count per kfd_dev? A kfd process uses all kfd 
> nodes on system. Is there a case that a kfd process just use some 
> kfd_dev?
>
yes, cgroup could exclude devices for process, count per kfd_dev allow 
device partition switch with running process that has been on cgroup 
excluded from this device

Regards,

Philip

> It does not seems the root cause or the solution.
>
> Regards
>
> Xiaogang
>
>>   };
>>     enum kfd_mempool {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 5be28c6c4f6a..ddfe30c13e9d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1088,6 +1088,8 @@ static void kfd_process_destroy_pdds(struct 
>> kfd_process *p)
>>               pdd->runtime_inuse = false;
>>           }
>>   + atomic_dec(&pdd->dev->kfd->kfd_processes_count);
>> +
>>           kfree(pdd);
>>           p->pdds[i] = NULL;
>>       }
>> @@ -1649,6 +1651,8 @@ struct kfd_process_device 
>> *kfd_create_process_device_data(struct kfd_node *dev,
>>       /* Init idr used for memory handle translation */
>>       idr_init(&pdd->alloc_idr);
>>   +    atomic_inc(&dev->kfd->kfd_processes_count);
>> +
>>       return pdd;
>>   }
