Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05D0ECE577
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 17:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D8310E615;
	Mon,  9 Sep 2024 17:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TAbUrbGj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8FC10E614
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 17:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9mECIPK7CUE1sZN2Qib409PftTejsqXrRtktKEF0Bo/nduEJPHdXFpTRI7qPue3y5/pmGYeTB7lyPSWcCKWIB9HYoqbfmcvOk68x33Waj81zwKEJkxfj56SntIpYD322wfcdhqAHVc2s2+BBluU/rlxiF89Kh9Xnuq7IFzx08kFu8JkTscARcpIKnpmouUwBDPqhZccFKPsAQK5ZBAxz/3JBgFSrHRCqYP1+F62nHeqH+XM4KjSkenSmuPYcSjIrLmSHGhxthIhKhtYyb9SerDA5EcoVxap9r2L7mlxqUesheQ+/R/wsM/gY0ucVCWPYn5n0b6RKGxNJT18knIuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPhDIZbF+OG9DUoHRf/LN3e70Encag43IN5fPRdo8wU=;
 b=Nl7EQuEc4W2+akRMcxXT7krLnUapA+xbarLAB2b6W6ge2/nUvB7rG0FGkcDjBjoAomvPrlltV4K2hq6XxQVXF5OgFoEM4ztLhXSUBuog36vhxK60lZNNsnfmrveM3WpYyb6tVAcFUxByQlvMP24U9Z0sIJHPvRQBCZlOHfD7bV4D7O1AXuPA07XwDqGMq6kXDZi1fJdUSyICbfS9vSC7TbOYwAFuuHdb1EZTNbDjcUWsgEEctvfbAzWJiGGQVOKmGCSeUSfC1gVon6I7EYfjIA5UFz5x3lccn+2xmJfKo7CSu/EoeqD6xnnuh0zY54wdYBCZTx9Rkno1hgZUyNFrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPhDIZbF+OG9DUoHRf/LN3e70Encag43IN5fPRdo8wU=;
 b=TAbUrbGjiIlJtEv+bC9/K85oshAOKT+mH89w50nNkbcigvFfGussFpDU+ivNKx0ccjhedQvV68TtOt0FOY/6nytHQby44WLlSpl5Lc9MUlKzPr7auNVCaYUt0IiBB07UyoQzlX8GqDOO+u+exaikNK0MFHgjgLPdPS2zgZ12ZEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 17:41:27 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%7]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 17:41:27 +0000
Message-ID: <5f5ad249-fd74-461c-916e-670024e87899@amd.com>
Date: Mon, 9 Sep 2024 13:41:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: Silence UBSAN warning
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240906144638.2464367-1-alexander.deucher@amd.com>
 <CADnq5_No2VCa67Yh8ZdehwOGcfoTE2WsRX4nHmqTHfoPw21H1g@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_No2VCa67Yh8ZdehwOGcfoTE2WsRX4nHmqTHfoPw21H1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBP288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::44) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 41612c87-1fa0-4bf3-b9c9-08dcd0f6a0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU5mQzJzMEE4ZjM0M3BwcXNTcTVsODJLQjZSZi81aCtsclFhbnVLVWtJZFFa?=
 =?utf-8?B?MnYwYzkvUzl5ekcyWmx2ZU9NYkErUDZLbnJhRXFLdDNCZlJyVks2SE8rSFlL?=
 =?utf-8?B?V25DTFlQUDRHSjQ5Ukx0Wjc3WG5tUjE2RVhSWHYvWkR6TFUraVN6clFDSmg4?=
 =?utf-8?B?alMvZzJ5WURIN2RDN2dCWUpTS0lkSSt0cXJ2bjg1OUx0N2x1MENqR0syYy90?=
 =?utf-8?B?YzFkd281WVU2SzhDZFhaU2J6OEpobDRZb3hxdW1kNnVLNXZzYVIzc25qYkw1?=
 =?utf-8?B?aEhkdHVFQ3ZBc1I2Y1FWN1hLQVNReW9rWlNYUFFlTkRBanp3SzhxRzZZa1RH?=
 =?utf-8?B?RTFRRyt0NWtEaVZXTTF5UnAxYlFEcFVmSk9McTJoRk85OW5KSWVtUWF3ZGdu?=
 =?utf-8?B?em9WVHhDVktDTUVRKzdsWnd4OVBBeUVIODlkcGZEYm1UWmRKcVhaRXRML21k?=
 =?utf-8?B?YVRZRjF4c2w3Q3VpekphSnFSQjJrdGxwZWNieUUxUS9URWtxSUUvc0RFdHpF?=
 =?utf-8?B?TXNnZVNpQ2QwYTZpZml5Zm1YYlBMOEVuOUZqMXRZZ2Z1NDBreExMa2RXdEVi?=
 =?utf-8?B?UVEwYk8xbFl6b0tqZHo4d3g2b2N3ampheU5QaTg1dkpwQ3dDLzhzbFpJQ3ZR?=
 =?utf-8?B?WDRzZHVoNldNWTNQbXdCcTlOMThUc016eUVLNHlrRVN6QlZiOE5tWTQ4TDgv?=
 =?utf-8?B?UU5uT3NEMmx4Z2kvR0hhb1pCZWpjdzg1a0RXRFJYSDNERzcrOVM3RWZ2TFgv?=
 =?utf-8?B?a2NMTm41b3R1OEhVd3ZrSGVnOFNmUnYzaWJYSWwwZzc3U2tpbjNTbTIya3ZV?=
 =?utf-8?B?eno5R3lHQXZWQVZIZ0huS2xKTVVaNUdXMmQxZ1h0UmdqaW1KS21Ua016WTZF?=
 =?utf-8?B?cWNCNkU5ajYxUGV4U1c2YTI4bEo2LzVWMnhwa0ZFUVRIMEZ3U2RhU3FBb004?=
 =?utf-8?B?OWhFODZYRHMzdFh0akhoMkJ5VDlaZnI4THlsYWRpODRYbTR3OVg5aW8yTGxN?=
 =?utf-8?B?OHdORTZaU0tQNzhSdnc1QzVYWXpySkUxakJmOUg3UGtpZXIyR0hrb3ZrZlkw?=
 =?utf-8?B?ZjFQZUtjbGlSK2NBUFkvS240L0tTaStRR0gyaEE3ZUIvTWNlZkdnUUlpeE1w?=
 =?utf-8?B?MUdjRHZiQS9icVJySEo2UU02QXVFT2JJVi9oWXNJenJnZGE2MldGOWZCK2dv?=
 =?utf-8?B?a0FKM0NxV3IrdnZZNE9SNnRPVzVRNXhTOUFWc3ZqeW12b1NBZTJOVVQwd1RD?=
 =?utf-8?B?N213OXc5dXVxd3paQ3ErNGlFSmcrRVlOOE1sTldIaENLT2xWdGs1c0F6WTdp?=
 =?utf-8?B?bERBZmE3VnI2Qm82RHJla240dWRxYXpXaGE3eDFhT0d6TDJ2eG9oMjdQeXZ3?=
 =?utf-8?B?ZzNINHBZY1ZPS2tHY1JFRjR0T2c4QmVRM1NhWmVoajBDNDVyRE5GVkUwQnMz?=
 =?utf-8?B?YjhHQlp3TlFzKytmOThvVDQ5ejAyZVd2SDcydWYrbFkzN3hDOE9tNnAyMkVi?=
 =?utf-8?B?M21xUy9nbXFmTXBaeGk1eVo0aGxrZEpncEZNd3YwQk5zS3FzRVpScjhxblpi?=
 =?utf-8?B?dVFDT2RlNit1bXBreXpmK2drelVsYTZEdWl4U0VNMjdzVHo5OGd2Y0ZMMDNs?=
 =?utf-8?B?TnRCWUpCOFpmKzkvbVU4eERWVmNUNnd3OTNNR2xiMXdTUkQ1azZDWmI3eXhX?=
 =?utf-8?B?a2JpWmllU2J0Umx4Nm5TSU9FcFo4UVFhU2ZET3hkV2E3aXA5R1c3M2xIa3NJ?=
 =?utf-8?Q?ZeVfjlbM0i4mSQpjBQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZRbHNqb3FLQVRYcVJya2xzWUw5VjZ2NHI0V3VFeStNd3BLdC81Y0o0YW8r?=
 =?utf-8?B?WVlHTkFIRkZ1dVNnS3JRTENLb05QM01nZzYxYzlVN2owVWpwTVRRVkE2bmpu?=
 =?utf-8?B?dkk0YThUbU42a0JYejFNR21hOXdpTjIzQStyNVJVVWZ0WHVxWTh1NWRvb3J0?=
 =?utf-8?B?cmZtYW9IM3YvelpKa0hJcm9zN0ExRTAyZGR5M2M0aXRyNjhpZDVFZWQ1b085?=
 =?utf-8?B?ekowZnA1NDlTOVhvOG9TQ0ZrTGREMzMrSjVVc2FEbVBReVRVaGRJVUtwL0hS?=
 =?utf-8?B?NC9jVG4vaXArVXV4VEYxckVXYWJFdFFPRFhiSEdCc21QbW8wNCtJVVRUSGc3?=
 =?utf-8?B?eitQZ2lNV1VZSE1YeHkwTHB5TjI0MjlUMDJOZ25lU2Rsb21GNFp2bU9LbGoy?=
 =?utf-8?B?c0VZYzVPeE5mRDR6MXRXcnkwbFZBK0E2eUxWVnd0NHJlZ01KUm1SRXpDU1VP?=
 =?utf-8?B?L2lzcEVEY2tQblQyR1g0dTJaZ2dlaXNXdnBkQXVERXd0NE5uV0NMVUM1Tmw4?=
 =?utf-8?B?Mll4dXlpZzl0WG9OVnE2MlRCbFNIZnZSU3ZiVGFzeDRad0dsK0hqLzdTbnpW?=
 =?utf-8?B?UVdFbXpuN3dhemhYb3Z0YXVoQ0ZCNGdSNUFqeHVzeThRUUlwYUxZM1RnTk9I?=
 =?utf-8?B?eVlWejdubGdTRmloN3dCZWc0RnZVWnp2ZXY4NVdyUmdLWTZFdy81N2xlUGVl?=
 =?utf-8?B?TTVlUUZkcHRWNEMxNVRmenZCZ29tc29vRVFzWGVadCtoaUdPMDZSQ0RaNElz?=
 =?utf-8?B?dTZmaFR2SEFHQ1IzR2YzMUNlV3JiQ1pmdkdzamhtUG5naElMcDI3UXRTQ1Qr?=
 =?utf-8?B?WFczb2tGRUZJODMxanlkeVhtVjFqWk9vTWp3YzVucWF1SDBtdkZBTktwZXFW?=
 =?utf-8?B?RDV2Wng1YlBQVEZHd3Z3K1RUVTZtcENrSm1wT01MdHYvenBJSjlob1F3dFNQ?=
 =?utf-8?B?K1FKUjRjLzhaV0NPTWQ2RGZBb0IxbFFjOVR0ckc4VHd0TW0yWjVaQ2F0andU?=
 =?utf-8?B?bHBLRHhyS1FPS09aN01yanluVEUxaVNuY21VRDJQY1hibGswY3V0bVNsUk9u?=
 =?utf-8?B?S2FWV0ZNakwrVGE5a3hZZEpVSXNBODNNS2VzSmltc0RoblM1QTJkS2Yzd1JC?=
 =?utf-8?B?ZTZWQ3VwaXhvTmFPR2JvZS9MajE0WlhJQUtsMXZDc2l6NHNadFUxTFArckxO?=
 =?utf-8?B?TURGdWs2TnArWVV2VTVORis1K0VTVjVPSUdpRGxSRlNnRVZnNHpjMUdZN0pj?=
 =?utf-8?B?b0ZVbUlrN1ZYOUQyTkoxMEpqeFh6Zi9ld0d4bjEwSEZIRzdKYjNybXFQZzlr?=
 =?utf-8?B?cDV2dmE0Vk5UU0RxU0dlZzFmQWpaZlAvdjYxc2pFTUVsd0pWRE5GSUlGTEw3?=
 =?utf-8?B?UGRaU2ZqL0RBL2tTODhsNGd6VngwQ0pYRzNUazFySytGSVNHMXNQWThTb1hn?=
 =?utf-8?B?K1hwc05UWG4wZjRQT3FESnJ5Um5Ib3ZXeWozUHM2VzQvVHczanJyV1ZEUjhR?=
 =?utf-8?B?eVlMMDlScExrZXdES0djdjRiN3V3ZnlKay9ZTDRTUXZyb25SZW9HRTV6akxv?=
 =?utf-8?B?eW4wWjI4eDliUmhJT1B3S0hFR1EwWC8zRjVWblRrVzUrV08xb2R1RDQyaWVZ?=
 =?utf-8?B?ZlM5ZWpDTDlnZjM2Q3l3N1FtcDk2WExyVlhjT1M3UWZzcmZLWjkzS1oxWjR2?=
 =?utf-8?B?NW9RQkVVSHo2aGUzNDQ4NVh2QTE1VnZvYkd0S29HNUdhS0U5Y05BVmRSdzd3?=
 =?utf-8?B?S3BwZFZlL1lGYzBDWGl5Ty9kaDcyQ25vRHliVFpZelRZc2VDaHRQdzdnRzRp?=
 =?utf-8?B?cUlqV21VOGJsTW55SDI2L2crUzNYWWhFNytGYmdBWXdFNFk3aHBiT2d2cmxO?=
 =?utf-8?B?RnFQSHF5ZEVuVkYzejc1SlhKcXRSdTdCQ3haNkZUa2d1M2ZwdVFZblZJNXhN?=
 =?utf-8?B?NE5VMGNHekQ3Z3krTmVMWXFvakhlUnVuR2VROEQ4MlUvdk1IcDdIZVhlNW85?=
 =?utf-8?B?NzhjRkM5ZitYa0lTRzVxc2FiUVR5eEdKYUVCNTJEV1Z6b2E4d0oxOUIzcmFi?=
 =?utf-8?B?VWljVE1Vd0tVY0ZoTUlMUS81NzdKRVN5SXV6Q1dHdFBVdS9OM3dpQUJWVlRv?=
 =?utf-8?Q?86A+XMiY+EoaBFsaDMMPN/vNP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41612c87-1fa0-4bf3-b9c9-08dcd0f6a0d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:41:26.9346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtMAJ3JXWvsjjxra+KaPypOqPyoy/0BvM/9hrLV5EeeR2BhU4unpdB2KjAcPw0VVNoB7Mit9h0Uq/SXDhI/X0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

On 2024-09-09 13:19, Alex Deucher wrote:
> Ping?
> 
> Alex
> 
> On Fri, Sep 6, 2024 at 12:43 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Per the comments, these are variable sized arrays.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3613
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> ---
>>  drivers/gpu/drm/amd/include/atomfirmware.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
>> index 09cbc3afd6d8..b0fc22383e28 100644
>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>> @@ -1038,7 +1038,7 @@ struct display_object_info_table_v1_4
>>    uint16_t  supporteddevices;
>>    uint8_t   number_of_path;
>>    uint8_t   reserved;
>> -  struct    atom_display_object_path_v2 display_path[8];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
>> +  struct    atom_display_object_path_v2 display_path[];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
>>  };
>>
>>  struct display_object_info_table_v1_5 {
>> @@ -1048,7 +1048,7 @@ struct display_object_info_table_v1_5 {
>>         uint8_t reserved;
>>         // the real number of this included in the structure is calculated by using the
>>         // (whole structure size - the header size- number_of_path)/size of atom_display_object_path
>> -       struct atom_display_object_path_v3 display_path[8];
>> +       struct atom_display_object_path_v3 display_path[];
>>  };
>>
>>  /*
>> --
>> 2.46.0
>>

