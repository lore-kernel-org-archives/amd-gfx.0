Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4873BCD68ED
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 07:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D6010E1B3;
	Tue, 10 Oct 2023 07:30:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E6F10E1B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 07:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W61gXA2WTdBEDFOFoU8yEU4v7aNAmOCFK76DfOcaAcudKQOWGH5d5uJBWb/aI+D1sLMSA7k+2B6QOFWSLcZp2Vmpm1yWIjaNDyiVQEZedLJnP/b2WJT0e42S4dP4W4Nu6aY5V0QTIZ8W78ostT1+7fRjgJ7dV/5auNtL8JULAMlfX8PqL1LI6143baDBtP0LDskcbUJM6T2eot1CSZDZKZnqpbLzhtcBHPEz5b94yf2XuO1JSDMTa4RVmdYJSNZdN1V4d2fBXjuZI5ZZ+nFSidcwDwb1nLxKprgAUMqgljJHKYGe17qKC1ax7ZeTN1r+/Ug8phYYM6w7V0bCY/ok2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOcoMxwYiOT6AsLZXwZBMp1gDL9JqObbUvB3nnxO86Q=;
 b=E5t94HTJ/DfrxrO3jycIRARdJAjF7ezTczk3cWp2Rnfz23gTVTDLQ6r/XJp9bgUXawy0zUWCFWpItW89BKEd6CQakUamHQEk8xNZ0wh27VqtuoS9mLfr8WJhTzH1oycyzeZd0ajDLfPs0fKB+rzYfi45IhLRucZGmoyC6CPhu8mI+6n2LH392a0zTLHVtSAucY6lRhgsuKi8zSdoUKpGrYMByuqldwFsRjI1Mi9hou5vjisI8ZhvYeHSo1fZH022NzSpXnYB0Hj1sPqPsbg7oDTrqTRsK3TOPGgMVEW5OK6z1Jq+nCfS77RK5wCOZ7pAdLj82nUve0MzAUpZw0Ae8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOcoMxwYiOT6AsLZXwZBMp1gDL9JqObbUvB3nnxO86Q=;
 b=q7f3uFHSS+w4tVl6vTKQgxaB3+5GHQpXRRBjM6yQSysTR9EcbFZTY5bVnwf6DwZK6oFSAMLzT99dDStO8s4pmTOIQZk9f+OZ9aR2trx0gJgIwHrNq1yQGwgYA28gek6Sz5Po4u/nrc8+TFvRxTxjneDIt1TsfRrGsJS6XCE3MHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 07:30:15 +0000
Received: from MN0PR12MB6055.namprd12.prod.outlook.com
 ([fe80::d8f4:cd66:a294:589f]) by MN0PR12MB6055.namprd12.prod.outlook.com
 ([fe80::d8f4:cd66:a294:589f%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 07:30:15 +0000
Message-ID: <66f3dfc7-d463-44d1-a23a-20920bf2014e@amd.com>
Date: Tue, 10 Oct 2023 15:30:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: save VCN instances init info before jpeg init
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010062734.40143-1-lincao12@amd.com>
From: "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>
In-Reply-To: <20231010062734.40143-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To MN0PR12MB6055.namprd12.prod.outlook.com
 (2603:10b6:208:3cd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6055:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd7f431-be57-42e6-0ddf-08dbc962bf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM7+CrtkdtnAgAHaQbjA23DdjexhMuhd7K5rZl1c/dQnHFUPJiqZe/0fVeeiCfbE7DZqu9Qtmkf3qPOxOx3qAsmNDXXuTI4brn2W8cWYOvW05T4DjAswA/+iMzPK0XCU5rTGSIFgT+T7exrdn4+YTF5i2pfp455fPREApcY05UcOpZFfe3vkkaVrTCbigXBLsvZtqUt4Hji5QsKWAJrbT/kPQ7ZmIRHf0LomRNXYR3ZxtMBTQ87XeyzjaPdlUakTqyCPb29gM9etJ08tJd/lGX9R1V/rQaEQy32YW4d3nee2q8UbVPqhmejxTp1Em9fFNGkHuizbzVog/VJVTFG/yn1+7EL+5EBRehnFXmltHQz8eWs3qI0TR5h6sMRO5LtNWaN9eg4EQ4anjpt1Sci4qlICLtrwGR+rmvAe+voeVQfxY39eydVBlh8Y4WPmIpgbXpPBSVV3SZjgFVYYgwal1r2PmMZ5mMrmt9b999l2p4MecJxSl3QPC2X4n7UdakeCnOemJpTSA+22LcpojwR85kroeaKGxV/t4XsM9BATTXE5yUMk3THpv7xGbOg3c0KkRHnQ/Qur+HaGEWjV1hGUVoxiCOjZi8EP2NFlSOu8Fc4n1Y6hnFtSNoNtdAZ0Utj9JgtlwL5BcgL8KhacbeR6Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(53546011)(2616005)(6506007)(41300700001)(478600001)(316002)(6486002)(4744005)(2906002)(66476007)(66556008)(5660300002)(8676002)(8936002)(66946007)(26005)(31696002)(38100700002)(36756003)(86362001)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9HeVEyRXN1VHFZQ1doL1lRQjFFcTJOVSt3RG5CQ2pKT0dhWjBJNUVGUHNB?=
 =?utf-8?B?Ylc3N1RKVEJlTHl4TXZvb1hsb1c0SVh2c0JEVlhiNUhlSFdFZ08rQ3lDdjBy?=
 =?utf-8?B?dVJneFdvNHpYZE1sbkZNYm9CekFkZUhjZURuWmhUaHloUU8rTU4vNW9jdWwr?=
 =?utf-8?B?ZXBraDBuVTlvVHpkRVY2Sk9mdThKV29RYWNNV0ZoNG05VTFINGkvT0NGZHRp?=
 =?utf-8?B?djBnUXdLM3RiNGNxam9ndm9UbUVkdk9XTUtaMG4weWt4cWlET2pSQ2xURFJj?=
 =?utf-8?B?dEthWkFtTW5Calk1QnlqUGFpNE5ucFFXUXJkdlRvNjJQcXJFVXpudXc1OVJZ?=
 =?utf-8?B?SnFwdWZiOUpYM3YyTVlNdzVjSWxPTTZWR0hFZVlobXN2SndjRlA4dkNiWmRi?=
 =?utf-8?B?dlczNG1qWnNWYWF3NElSa2pJV3RNZTRzOGlMWE9pVExSRFQ0NzhhanZqTEpq?=
 =?utf-8?B?LzRtWjhZWGtQY3dXd1VNalFMZERFNVJ0V29wMkZkTVpJOFVycHlLKy9uTzJW?=
 =?utf-8?B?cW9wbTUwRTdJYVcwTWdheC9kWEVSNlQxL0pTYjV1L2UwSEJTRjhobUdSbmMv?=
 =?utf-8?B?V0kyWFpVMHh4YXo5ZWRRakNtbGlBZCtiMlNydzhiSzhlT1VRTlBkSFdUZWJz?=
 =?utf-8?B?U3VLclJMcGRsd3NJdllJUUFrby9zQjgxRW4zODRyb0ZSTVFGSFVNbWFGUlNL?=
 =?utf-8?B?L3dBRUJna3hpK0dydmVPQVJnVm12NWF1VWFnZWpyemdSRDlYbHpRNkwyUEF5?=
 =?utf-8?B?Y09oZ25Gb1RIZ1E0NkxxU2sycWhkZGVjVWhYU3I2TWRNT05UVWNWSll2M2VN?=
 =?utf-8?B?dG81K0Q5Z3J3SXVWSlU4U0RlQzBxekU2ZVBLWWhHcEIyN1BUc1E1VmpWdm85?=
 =?utf-8?B?TTkrMFBXMUpMWkhZeU5ZazdGWWpBRWhjUEZxekJhUTRvR3l2UjJaekJybUx0?=
 =?utf-8?B?Z29IMjJRMkkyblNlRXdrTmhtS3pxR3FlV1BiTzE5TjhleDVFSGRLZUxYQVNB?=
 =?utf-8?B?dTk2RlhPd0JFZGY0OTJOWGZiT2V6TFF6bEdEeXpqTElESlJJU0NTcDRYZlc4?=
 =?utf-8?B?bWtESWt6dnh1WXJFVkJyUUVaVElha0ErNElLL053MnpwSzg3Q05IWTJjU1ZI?=
 =?utf-8?B?ZVBqQUo0OXJreWxGT0UxZVRFU0EyU1MrZWNUT0lhNEExRXNJaUJsUnpHbzE5?=
 =?utf-8?B?aVo0bFBBUmUvbER0ZXZTMzNXdGF1Z3VWNjB5Rk5GSUM4MEJFZU0rOTgxWVBG?=
 =?utf-8?B?ek1vME9LZ09yR1h4RXNCZWNHU24zMFlGemtjL1RtRGtoQ1A2NFo5VzVQVWpE?=
 =?utf-8?B?alUvVnFnclNjbUd0eitKaTg1Uk1WSk5keGtaRFliMnIwVU94NlRxR3BxU0Er?=
 =?utf-8?B?UWNUVFNFZENPVWZseGQyTk12V3BMcFVZSlM0Y082V2wyWFQxN01mSkdUWndx?=
 =?utf-8?B?QnQrRDZ1N2RwMjBGNUhMZnBxZXBjNFAvZ0xsdnpmWU5PSmtNNlIrSmEzQmZx?=
 =?utf-8?B?c1F3bWd1Z1FjbnpGOGRnQVJOd05EOG5MUExwQ1VJSUQwMHB3bmZyZEh1blZF?=
 =?utf-8?B?SlVPUUV2N2ZlMUFVSVE5bVJwbHZKbG1sbkpCaFd6M2pDL0xvOUoxNUlBYVcv?=
 =?utf-8?B?Um5Sb21BYzJKYTlwUE85TTNTQk5ZNjlvVU8xdGx2M2lBRis2ME5xRk1KL1BW?=
 =?utf-8?B?OFZCdzZPdmJUVk5vQnZFV05YbU9yOERHMmRTVkdVYkdHcVZ6NFBxQmFydU5y?=
 =?utf-8?B?cnhoTEsxcDFyNEYybHV2UitObytyQ2g1U1BIL2xNU2NKbTFPUGJDaHJwTlZF?=
 =?utf-8?B?SnJKaTVBYVhjeXpsZ3gwWUp4U2d0MXJBUkExR0ZOSUZmNzdSa3ZaN1pxWjM1?=
 =?utf-8?B?NGRmaXdtZ0gvdkYvdGMyTTNEejkzaHdaczVzM0pwdHZINnpwTzltV1F2S1Zw?=
 =?utf-8?B?WExUeXhUdDhnQ1Y4SW51MTUvN1p4bkZUY08vSTRqWWNwSk9OZHZOY2pjTU1s?=
 =?utf-8?B?K1pObG1UUmF3N0UwTkxRK0dVenE2REpyTnk3S3pSOXNCNWMrc25aNnV4YnBv?=
 =?utf-8?B?U0NNTnorTEY2ZmdHamVMMzJBejhIZHJvQ0dOSjJQazBsZE5pc2pEbVlUR0JM?=
 =?utf-8?Q?t0o296Gk2xXX9lF1t8pJo5J7q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd7f431-be57-42e6-0ddf-08dbc962bf3b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:30:15.6834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0Y7UJP33otOsXXM5YeGcpvvzDWHy8nQ2AAOsATU7oSurdZIJLjxG36IJVYQfIr1lajCffgukOnQxWQsrjNLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

Reviewed-by: Jingwen Chen <Jingwen.Chen2@amd.com>

Best Regards,
JingWen Chen

On 2023/10/10 14:27, Lin.Cao wrote:
> JPEG init header will overwirte vcn init header info which will
> loss some debug information
> 
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index a3768aefb6b6..bc38b90f8cf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -431,6 +431,10 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
>   	end.cmd_header.command_type =
>   		MMSCH_COMMAND__END;
>   
> +	size = sizeof(struct mmsch_v4_0_init_header);
> +	table_loc = (uint32_t *)table->cpu_addr;
> +	memcpy(&header, (void *)table_loc, size);
> +
>   	header.version = MMSCH_VERSION;
>   	header.total_size = RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE);
>   
