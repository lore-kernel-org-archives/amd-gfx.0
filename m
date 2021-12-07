Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 20:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00EFA6E128;
	Tue,  7 Dec 2021 20:37:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E939A6E128
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 20:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+EJcFnMojwb/Sy3KgVFizH1jSQelMJBOtkoVuPE4Csi62Lrck6ILylX33kiwwiNIATsqWeRUrhOQLMrJjnpDj6uadB1ie8b5SwoSquRBUcOwJlJjSRL9fl7Ys0rbLQWZ/Y7sa1Q9DvS+L2yMV//xEYx0U2nJSNGL/p+ZnW+mOyonwroKnMMKt3BN1MuiAKC/BxiuMvGL14+s9o0XrolKWdH96PAuTB24glgKe72hIYqoCG6gN7hpEvTToTMLlp6VZj6lyYKv6lRDTNEkuTdxh6vCgDDggEh43ivXUog//nISIeyZgzeC7sKONthu2fP5t+X+/BCW+mYvi8KkTElfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EipvpypfVbNq7Nl4vJRwQZoGTKnYc/FH99gL67S3G1w=;
 b=TqCgw9s5F9DObr+StR2YCWsURmNL07YlOZlqfncHu88yoZElJMibPHjNuLSilGckzSLSiGMeATxcD0JEl0za/6OwE0QaSrrZFYSjCehRmU+oQVtQE2ZOyryCZqMMuKI1UJjFFVUTsBYLN/Huo9RYe5voKMkrZqJLTw/CMfOGVOQ94zE3x5kHABJ3zJqcNl8KkyD0hhtPLATfl/P4GgdKZvouW2YQ8dF5decKC8P06Msh2Wa4uD3MnQiCuCgtzdOkIFv71J/b3Lk537eKnfkGL6L3iSUNsdXFkgIop77QtvR3VH6glvj0+o21/q/J3p2Pa4kap+cxMCFTXh/BZJbx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EipvpypfVbNq7Nl4vJRwQZoGTKnYc/FH99gL67S3G1w=;
 b=ZyErsQ251DH8KrJ6cLmUthNA3d/JS3u1zCWhwtefHqFAsZvmYIuFhbjzmYtKn4xlw+Fe11zCuAz6FGfwIjoWKQFAQvHGANQ1uW22sRX5SkFEu8L8eXLl7wDQ+aqb0z7+3dkk0Zka1j84X+/wybDpFxGM6LmFObxSDGB/gl/er5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 20:37:38 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b%9]) with mapi id 15.20.4778.012; Tue, 7 Dec 2021
 20:37:38 +0000
Subject: Re: [PATCH v2] drm/amd/display: Add Debugfs Entry to Force in SST
 Sequence
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
References: <20211207195703.352933-1-Jerry.Zuo@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <3d97cb28-95b8-e4df-cfd8-b8325a92451c@amd.com>
Date: Tue, 7 Dec 2021 15:37:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211207195703.352933-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16e1659-6180-4922-e85d-08d9b9c16846
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5369C5E7CD1161E047A042E58B6E9@CH0PR12MB5369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsB8VFV74RrdWLDrTPm18VYye49y1yEjC9sMR+mRjZCLrXVtYR1/6S97d6A43blOP5ofbPi7QYuyeWIYuO6ekEJZkhNZCCQTZTvHYkEchbr9CKverastujYHOU1BjdEN5lUZmJUR21Hym+P6uqtCZvHY7jaAx8Ty6xsjXPOHWF0lcZtmEX4R5u8W1RgARoPm1qdib0MX8JjcUo6FgbRPW1XRu9+hMK+ZQVr+5UZ5/xMBqusWkjiGOYdpP+OPeNNG592iKlWVhBfSfVQqd71qcjlngNjLb7zFG/r4nkEVMppg/290+RouHyrRqepvmDBN+fVsgZfvabhSUX3Bbrjnut7AhpoAw0j5uPrqg88eGOHlAihscDgHPDZOH4awAMQDZ5OY4NT+fFZVu9j6cRPd7U5KLhzPkkyOg81seORoJU2jktPRtVCJDPyo1vdfOIrQIqT3biZ6D3cSsf/ApTlU3c33lAnMnWlqVr0jcrUKQsPtgr/MGj8oAcyWzQjtYASE3V+HUlUdaLZVEGbelTw22MPr16Y5r1Ctj5RFlhWBYKfs/SDH9eW6s8ZVqmx4mrBtqY0L/1HMA99o8Ts1z6aC68hQOVp+G2OT2FhCeLA4kRrcqkPipQo4mmCn1n1V6+ZycUID0o2TAb1M+kMUViSWSwSmcpn0bmAOyedSY32M7DKnBX8Bm4Vj+BirpCsF6cffrD3TU+OCdxbCnL5eCSMyd9yqqMz2sg8Fh/k/1FdonRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(5660300002)(86362001)(83380400001)(31686004)(66476007)(508600001)(6512007)(6636002)(66556008)(186003)(2906002)(66946007)(26005)(6666004)(6506007)(8676002)(53546011)(6486002)(36756003)(4326008)(2616005)(8936002)(316002)(44832011)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJLdjNnb1dIQ1MxNyt1T0tiUlFOZWdSaGZaMGd0L3JaZGNoU3VFWXpvMXJX?=
 =?utf-8?B?aWpLWlYwemFCMjZpTXdOdTBieE5oSlF5WERpMElMU2Y4bTdRTktJRm5UQTZC?=
 =?utf-8?B?b3oyTWxETG1XSCt3RXJ0ODBvQXB4UmZIclFRVVNmOE12MVlGbElYclA2bVBj?=
 =?utf-8?B?aTJleXpaaXZrR01iQ0JQWDJIZDdoajdBWk5qTysxUEZIcHNUdmY4TExMK3JP?=
 =?utf-8?B?MlM4YWFtaTk5QjQ2TG12RXFneU9Zb2JsZHN1UHZyc0ZjSlczMmI1VWs2Yncw?=
 =?utf-8?B?Wi9BaVUzVFdHNEhMQTRmYThYamIzdU9lL2ZEWDZ4eVp5clpKWjdaMS9nVTF3?=
 =?utf-8?B?dkVhVWQ1cTJOa2xleUtUTzVoQnd6clVHaDk3a0JaaUlnc3doZmVqK3FpZkQw?=
 =?utf-8?B?YVBZemR1WGJobTRvV29SQ09Yd1hGcENTVmJxVEhwWlIwR2JveUdDTjdWM2xw?=
 =?utf-8?B?aDFqbkxPTWY3RkljU2J0Q3c0eS8wQSt0c3hQQmVUYzRFUDIvdjJiM2ZHd3pD?=
 =?utf-8?B?MUdLV2NGYjZocDYzMzZCYUszRENqOXZVOW8xZHhlMExKZTdPaU9XQTRtZyt1?=
 =?utf-8?B?ODFnenlNNndvNGZBMFk3c2RhT21KdEk4aVJ6SU54MFFseHdQSjJQM1N1TXcw?=
 =?utf-8?B?Z1NrUFN6ZXdzenRkMXNNbVE2aWU4aFRJSk1CSWRGK3pMWkYzMTA3Q2xlSmJK?=
 =?utf-8?B?d3RtZnlhOExJbFdOaEcvd0JLNVJsYmJTQTI2bFJiQmFUWDBVSVFvQnpBR1ow?=
 =?utf-8?B?WlMzdndrNHZlS1dzZFBvcjd6Vk96elplS2llb0xpdlZJZTZlbkF2Yk9oOWVC?=
 =?utf-8?B?aE5VeHV5VG9MMlRtUzlQUll3SFRGVk1veVBjd2ExaUFVdFM1djlIZm1pTmZQ?=
 =?utf-8?B?K3JqbmtMNzU0UHgzY0pCWm1wYVBKdkc1TUdOODJrNVJqZ1dmQ1VxVDFMcEc5?=
 =?utf-8?B?bjhXV0xzMVArVnQ5VlhqYXFtcmFveXh3YmEzSk9jZDkwMEtUSjNCQmg2UFRo?=
 =?utf-8?B?NFh6SlVMVXBPZit2dnpBUVF4Q3VNaFI2SFVvSWV2czhlQ3p4d1hEWWNtaFdG?=
 =?utf-8?B?N0hWK09WZ3NmOWNEc3lQc2hWTVZNb2Jjemt6WEQvODNZc2FEanFpeW52Q3hi?=
 =?utf-8?B?WFJ2R2VtcFlNMzBiM1o2RzAxbDVUZm80MiszamxOK3phL2V1R1ZzYVNXa3Fu?=
 =?utf-8?B?MUFSQ0syaGhyN0RwZGNoRWx6OWl1NDY0c1Voci90REN5TDZQYVdZcDRhZnNC?=
 =?utf-8?B?alBWeUF3QTBrbEtWL2dxSVZsUXJnQURrU1F0dTU0d1owM3BmaHFnWnAwdENB?=
 =?utf-8?B?enM5UVhoSUpXZkdKVnN6c2JzaTRPUzI1Q1E0NlFVNC9yWHQ1SFZIclBTRnA1?=
 =?utf-8?B?R2RpTWJIMVFTc09CTEpSRlJWenFBZ3ZLSlczTlFzTlVSZ2JtWnJGWWpaT1kv?=
 =?utf-8?B?eU5zeXl2TnhLT2pCMzJJK2oyOVpIMzNlL2lhVUVBNWloQXVublRMRlU3dTF2?=
 =?utf-8?B?bldtbmdjZ2R1T0hKVVQ1QkJWOE00Q3hpNHhxRGl1NHl2dnJ2c1NzamZSRkVl?=
 =?utf-8?B?Z1dtQnZlWStRMFhNVXJXd2FzUUhrZm9teW9qS2gzK3VVdk0rU0Ixdmh4b2Yz?=
 =?utf-8?B?RVVqTWxINFByeHQwWFNrMlFBOG5CeVlmenlJSmc1NS8zVzZOS0FLTTg3b1ll?=
 =?utf-8?B?NWZZRkgwbk9UVXJGUDBtdEh6cjV2dHBTWk10Ky9XV3JibVFUUWF2YUdPa2xT?=
 =?utf-8?B?N08xSS9SUW5ZWURHemR3SnlXOE5UYjRSelJaK2NiTnFxTGowdjVYc2Jqb3Bj?=
 =?utf-8?B?ckFZbitwWHVMcXZFcFpwRmtidVJycTM2SmFQNjZ2akF3a0dseGJTVncweGhv?=
 =?utf-8?B?SFhFZmVSMzB1VFBBN1ZSTkpFamV3TkI0N01pVmx3RHZqVHM4Z0JnMU9DMVFX?=
 =?utf-8?B?Y0NhKzRkajNtNEtUR2xkQS9abjZEcHZqMTE0T0dVN0dJVzd5clV5RjJleldo?=
 =?utf-8?B?ckFHVlEvMG1pMEM0QWZvYnEvSWJEcm1nMkRxNmJFdEg2bE1HcFVlRFdzamNW?=
 =?utf-8?B?a1NhRlh3RWRBSnFacHUySlRUUWhSMFc2TTZrUENvaE1GV1FRTDFNSkMzWGhy?=
 =?utf-8?B?Yjh6RkF0cHBsenZWS3ZzRzE2Rm5FR1RTQlRmL2RKSWljbkxIbHNaUTNWS3RR?=
 =?utf-8?Q?0BLPVmCVatyxmQ+V7D9QFI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e1659-6180-4922-e85d-08d9b9c16846
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 20:37:38.0345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma3C9XKzEqQw8vA7hHZUnl9rBNIuDCSi6TTqNlc7xTcJ2TjjRdnwMiRCy+B5+Tzi5c6Y0YVcgBjsmt4Ftdi/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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
Cc: wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 12/7/21 2:57 PM, Fangzhi Zuo wrote:
> It is to force SST sequence in MST capable receiver.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 31c05eb5c64a..1779c7daaf72 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3237,6 +3237,30 @@ static int disable_hpd_get(void *data, u64 *val)
>   DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
>   			 disable_hpd_set, "%llu\n");
>   
> +/*
> + * Force sst sequence in mst capable receiver.
> + * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
> + */
> +static int dp_force_sst_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	adev->dm.dc->debug.set_mst_en_for_sst = val;
> +
> +	return 0;
> +}
> +
> +static int dp_force_sst_get(void *data, u64 *val)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	*val = adev->dm.dc->debug.set_mst_en_for_sst;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
> +			 dp_force_sst_set, "%llu\n");
> +
>   /*
>    * Sets the DC visual confirm debug option from the given string.
>    * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
> @@ -3346,6 +3370,8 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
>   			    adev, &mst_topo_fops);
>   	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
>   			    &dtn_log_fops);
> +	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
> +				&dp_set_mst_en_for_sst_ops);
>   
>   	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
>   				   &visual_confirm_fops);
> 
