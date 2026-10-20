Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CA60A2607
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xlA8iifh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE89610F6CC;
	Tue, 20 Oct 2026 15:52:27 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4354910F6B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 15:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEk+zalBQYeQrd1YZ+yK0u6kDY/4a87RFtbqUwGv1WxvjnK9ZoKYCpsgzDDMst0OTNtGTKn3S+071JBJSTzyYP3GBC8TuZ2G/YG5Ox9DKonoCJMHvZiFCny/xc1Rd3rPdDtpvMpMqMZwnS2OMjliZegkaOJm769qlmkZxCkrc1uG9V5IbjWQvfeHgA2uJ4z60M6/r+b0UPkZJvhlcxd9iBei6Gb512JuGenXz4Ct/pWFXQXFiJ3YkYIJhKlIx/MAtFqVzhp4N8XMqa4hP5rGft+ezI5HENh0ElqeO+razrFaASFgKZwiKlSusS1C2/3IQkIYzNOTM9xyiAgcAOfsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgvfACYk4eTYFPyb1bxVSweKknCSJJ+UM/9nnvLd9cY=;
 b=FUYGdt7S6ZAUv/+Qm5gcNz0dLK06SFVxMZV9tl/LlLlu3xkwvJo6cnsyYn6boprPGjqnlPbOBVWzjlOihg7bZg4Vx4NnaBEezbmcM6fnu6JX+aMYonE93gsFzWhAQYMBBdOUTwkTWbzyxbT76q+v9HTST/fdMJkzJtSGYr2M3pnBqrvVh6kacZwxDVb9xQ/jQ/R1Qo727b8vNEDGuQZovGzScdsryaXejaNZ+/Y9zQ6oQAdQ+kmy2/WSGQoEUzp7jVk8qCpBpHHJG9DDqCOats0Dud6VBm87zM9tmPpbDXsCtsz98XtY9olWyHhEdP0o8pTy1NpxbO/vp5/3Lr4SbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgvfACYk4eTYFPyb1bxVSweKknCSJJ+UM/9nnvLd9cY=;
 b=xlA8iifhyEC3J5kQVZVQ/HO6FPtWH6NGf6sIs+VA84qkKxwiEHXEUznBVgjgIIFKFYAa6ai2Y3KtnlnRfhIfM6vI74pICqZZAIGMNIHV4xlJW7gEeJQciYE5tlQa35NVm+jYxV5t1LQeLwD3HKzS2PmrEuYy0aH1nNYycg06BLU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 by CHBPR12MB463627.namprd12.prod.outlook.com (2603:10b6:610:36c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 15:52:17 +0000
Received: from IA1PR12MB6259.namprd12.prod.outlook.com
 ([fe80::ab75:3bfb:bfbf:5f9d]) by IA1PR12MB6259.namprd12.prod.outlook.com
 ([fe80::ab75:3bfb:bfbf:5f9d%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:52:17 +0000
Message-ID: <2d9d12c9-2fad-470a-ab57-92b4d8c23768@amd.com>
Date: Tue, 20 Oct 2026 11:52:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/jpeg_v1_0: allow type4 commands
To: amd-gfx@lists.freedesktop.org
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20261019200726.15262-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::12) To IA1PR12MB6259.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6259:EE_|CHBPR12MB463627:EE_
X-MS-Office365-Filtering-Correlation-Id: eb16a21e-14bb-4dde-1582-08df2ec21dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ipnkBopP3oNwaR//82/1zgsxrgbBiy5qr60AZM96syEiCL30NLkH55PWJVUM5LxSKKTZDuheKYbaOiyihKv8GEGYu1oH18PvPdySlrPT8IoH9E5dWz5OBEl2dB3l8m3duTltNoIJGqKShTVpNqfAE+BlYS6YA3MZnogEDT6KLXQMjDzWTLV4Fwy7L9cS/564CtFprTqvP8jq1yKiKA4N5YVb+TiuNiaNLBrDb8xXuC5olHUU5DjWp9rfuYmRyJr7vv7zkmqFj3bnheHYk37dp0WyaeCfMnZOl8vLqjmMsD+iBJUByvl+gdncG7vK2mG5dvg2NMWENYCGnbP7xg1iMeCFwZdWv3tXaZ4bdKbIr3n4Xhcb0wqRn9nBkyt5VOAfakuxR9MvX2wqywSTmNzNsEqRaseHv8XHp39dHWp1oDvr2vsYwcI7OhAUenJTN3EC0cADpnSFjHkzJsiT9/NrS3TMrReHZZQuzE7EISHF9UONS2NpQE1Fr+BVQ8r8pO98djI85vdDibT7eMOzh7/+vAYZSfzYv5e2KbRpdUz4SRQG2nQbl4Y4Ti7azTC07Bsj/rkLG31FJEWLg4JXUOVb6W2zafVs2GCDS4EcSp2xqMUs/ISfHexU+4m3QE/1f/FxFDz8o2rZe4g2k7PEeXSQvbt2+6Oyy64OGBuK6pX16eM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6259.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRKYnlDT01xSTc0TXFGUThQeHQ4ZnJLckFjUzUweXpvZVpJdU02YTB0MURh?=
 =?utf-8?B?MVRyQm1LOWt3OWUxcWhYSm5vNEpSQ0F1ZDNBcWJoNEk5dHl1MGhjWXpHZ2JQ?=
 =?utf-8?B?Q0k4S2tRZ1BOR1BUb2Y4cWNocGJVVUk2M3Jndk95R1ZoRjNtMjcxcVFUUXh4?=
 =?utf-8?B?emUyTlJvbElFa3kwNWZTd3I5c2owTGZWQzE4ZVBDeUpDdk1YYzMvOEljZ2o5?=
 =?utf-8?B?OTVRd3RIeU9WQll6azI1eE5NWUU4R3JYZENPMFZUc1dsY1kwQnppUGh2TjZY?=
 =?utf-8?B?ZkNaTUZZZ1N2ZExmSG9oN1hDb3o0SEVHVzRGVU12SjBVWnVWY2tWVm5OQVJ5?=
 =?utf-8?B?UTM0cXZHM0M3MEhKT2p3M2ZaNVptZm8zWHUzbWN3ekJ3eCtVdVJDWEJwV1lL?=
 =?utf-8?B?S2VQMlB5aGhPbGlXdUNSSlJLOVV2OFAxZmIxOTBubVdUNjVMeW5zTUovcnRi?=
 =?utf-8?B?eU8ways2Y3ZqLy8yRWs4czBCWXgxWURwSXdWdnpsRG03T2RjaG1PeTk3KzNj?=
 =?utf-8?B?blllbXVPVml3UFhqMDNkNnRqbjV6LzlLL3pRdjY4OVJOYUF4QUZObW9JM1Az?=
 =?utf-8?B?TVZ2NjR4UUFDTTEvYnUxQjVvWTMwWjdGM0tIWGlhT29lR1RoTmtmMzVSSU9z?=
 =?utf-8?B?R1A2VTZSRTdyZTF2M1o5cE9na1pIemRXRzVVd2lxKzRzbzlBb0s2QmdKYWpW?=
 =?utf-8?B?QThwc0RjMEp2ZE9KWndpYUp6M212emk0ZE83YS9kME5icTFQZ3dhNGcydlZM?=
 =?utf-8?B?UmtOR0NEMTI2NFNBSTZpcWtBdHV6Z25icktiQ09JQjZZeGp0ejZPZVpCaHlz?=
 =?utf-8?B?cWMzSWh5TlhaSXg4bUJnODArRjRUYmlFUTI1OXp2Z0RqUjFVTHk4a2VHNjEw?=
 =?utf-8?B?bzdXNm5ZWG1kQ1Rra21NaUZoZldrclBKdGpoajBONmFUck1tcER5ZVJaNS9T?=
 =?utf-8?B?amRGNkVQRk1pU2tycVlMYTAvY3d1M2dmS0QrWk5HVlc0QUhYamNoNnBXam1w?=
 =?utf-8?B?bnAreGh2eWVSNHQvalI2K09xMmc3SW5YQStheU9JMkJSS3JpNVFYMC9ERlNx?=
 =?utf-8?B?U0dROUwvaDJ5WGN5MFBNN2hIQnRaeTZCRFNkaHFsZittclVVM25TVWxWUlY5?=
 =?utf-8?B?aEZZRy9rU2FxWXlWTUlGM2dyRkpsRnorNFB4RmJyS3RhSG1DeFkxN2ZFc3ow?=
 =?utf-8?B?ZFdkMm5pZG03YjhkNnUrRk52SkhHcGcvcUsvSXZOTktuVWNDYlBHYmY3aWdE?=
 =?utf-8?B?MGtXa25CT0ZEWFhFWkw5MEhiemIzWksxcGdVUlhtN0ZibEdJYk9PZnhlaXBh?=
 =?utf-8?B?SmVEMkZweUZSeDJmSnNONWNsOXJkZ096a2x6NFptYldMME10SUM2RC8zODM3?=
 =?utf-8?B?Y2lRWm5zRTZLbTdaeFJxaUwrUWxaM1UxS2N5MVYzdWRSTUdVa2JjelVxeVFG?=
 =?utf-8?B?UjIrb1d2SEZZcmtGeXJ2cG83eHRXL0pRcDRxdjZoOTBMTkZsTXhPTFlNa1V5?=
 =?utf-8?B?b1ZFTitSUStsbWRPMUluaFdVbFZwaDRlR1FCMDZuTk9oVFZaRXJkQUlrYVdU?=
 =?utf-8?B?RjFYRkRCT01Ua01xM1F1Q2J2ODVvcFRleVZMNFVyclJyQXBYd0N2cU1CcW5V?=
 =?utf-8?B?cTk5ckFoL3czbG5MUzhwdTBieG44VWdYd1d3bWk2eVUyYjY5ekh4S2JBWDhh?=
 =?utf-8?B?QjhMR2o2UTk1K0dYd2l1TGhnVGRGa1RrbmJ3VkYvRFlmbFlWSlM3ZmtYMFFK?=
 =?utf-8?B?R0NjdDBKRUpORGFlVVlEdDFKZTU5WkExNU1FZ2J4MWJTMm8vK0x0NHQ5b001?=
 =?utf-8?B?VllYZHhEVithd1BFYnJaWmVBTmlrSE5uQU0yaHV3aDBnVDdCT2NMUVlmMnoz?=
 =?utf-8?B?U08wWWRZSHZsdVdvM09pbE85alJXZCtROTJqVUp6WTl0VVoyWEM3b00rM2pT?=
 =?utf-8?B?cFo5OUhnY0JXMjdJNFpuU0lQQ0ZDWmVhNE5oMnRqbThYVk9zV1BxdjFPYW9L?=
 =?utf-8?B?N0ZCV2plamRCSmxLTGFYVWhhcnRySFNIWDM0Y3VKTEpjQzRMVkduZ2xnb3dl?=
 =?utf-8?B?WEswdkFIRHhIa3BPSzAvSFNqdVpxYW1WTWxaUmxLUVZMNEVOVm9iTHVjZGdi?=
 =?utf-8?B?ckdaN3dHTjFxSkRSdHBwb1JQRDFFL0w5YnU4YzZLWTBQUi92SThSajVmOHY0?=
 =?utf-8?B?L1lCOFhqYzJMd2M5UjRUMzYydDdTeHNzR2xNTjJHc0RwVlZvU1NWYStXRjll?=
 =?utf-8?B?RzB4MUdsMGc4c1AvR2tQR2FMZHVuVlNYcmJueFJHRkdaNWVNNUQzbmlRUkln?=
 =?utf-8?B?L0JnUWI1dk0wOE1sNTV6WDVKTEFEY1gwVzNwdWhLQTkrTzZsSEMzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb16a21e-14bb-4dde-1582-08df2ec21dfd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:52:17.3078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrnXYtmTjO1D34sUBJevHHkA54e5GqYBp3SgUAiHXND2n+yQqctQ0IJ+bDRWw4YEB4+IyVCBTcf57VvIc1ukZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB463627
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2 fix looks good to me. thanks!

The series is

Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Regards,
David
On 2026-10-19 16:07, Benjamin Cheng wrote:
> Packet type 4 is used for conditional memory write and can be used to
> allow a memory write from within the IB.
>
> This write is done through IB_WR_VMID, which previously was set to 0 if
> we do IB parsing. After programming the VMIDs correctly we can enable
> packet type 4 with no issues.
>
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index b5bb7f4d607c..81facb99d885 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -301,13 +301,14 @@ static void jpeg_v1_0_decode_ring_emit_ib(struct amdgpu_ring *ring,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
> +	uint32_t reg;
>   
> +	reg = vmid << UVD_LMI_JRBC_IB_VMID__IB_WR_VMID__SHIFT;
> +	if (!ring->funcs->parse_cs)
> +		reg |= (vmid << UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
>   	amdgpu_ring_write(ring,
>   		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JRBC_IB_VMID), 0, 0, PACKETJ_TYPE0));
> -	if (ring->funcs->parse_cs)
> -		amdgpu_ring_write(ring, 0);
> -	else
> -		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> +	amdgpu_ring_write(ring, reg);
>   
>   	amdgpu_ring_write(ring,
>   		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JPEG_VMID), 0, 0, PACKETJ_TYPE0));
> @@ -669,6 +670,9 @@ static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
>   			if (reg != JPEG_V1_REG_SOFT_RESET)
>   				ret = -EINVAL;
>   			break;
> +		case PACKETJ_TYPE4:
> +			/* Allow any wait reg */
> +			break;
>   		case PACKETJ_TYPE6:
>   			if (ib->ptr[i] != CP_PACKETJ_NOP)
>   				ret = -EINVAL;
