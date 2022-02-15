Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70107C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 16:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053F210E4EE;
	Tue, 15 Feb 2022 16:40:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B7610E4F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 16:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E11pGHdJ21tclux4pZ6drL7fhYEzo22lrrFoRcWOw1CiaxzsSZF2m7e+aa6pkv4ekJcTU/nLwtu4Meus4skH7dJv4BUWlp3I3p1+vD+f4MaVwuw1TLlecZJ0L6FxMzGxROIzZuxjpHGHQ+3efN+ZkxY1j1lknIkL3B7UNIwdzh9WKUNEYGJLYEhl7fdsAXHS2IcvA9lFEL1NELMnENYCVPkM+4buXarpIwDFpjzHiZDb5MDZpzzDk9MeATKdyDKDJcRnEPrjbEE5i7+akqGh9wDrDSTF9P3Zohg+/P2QRYAD6ZJeVHIVQ1Hajr9nnrcCSSTNkW6B7J75vqB7h5pg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHaNQCY1tBt7NGnLd4hUqk4fsieVS0fiEPLKGQSB3E8=;
 b=E/tME+v7w2hu7/AEywWjssL3WXuT7TnrONnLC6yvbkxQvBSIxSjUAwlZptZ42GOLIvUlpj9fezWUBOUziZjBg5nmppJHm4GSk9cgKrDswv/YoXtoGtdQtPkrIoc48fJACR+O+rrhHUhfXJ9JcmoVdBU601m62lNsvrioKZ20BjlREqKWxe1uLv/H6Qc+ROeij/iphfH0AZN4wVnCf3j58Gev38BcG9TKMw9NCFFD/VE+plZnaOhNpfG04WLHhO7b0Ghd8Cc6JArij30+tnk4YfEHB9N56+Nqph706+0fKKM9uNbEuEeVtszXQpNQNFXM8C2rT6uZQnRkGz7LlFzIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHaNQCY1tBt7NGnLd4hUqk4fsieVS0fiEPLKGQSB3E8=;
 b=c6MX3jZbXmpPEuqMaPAyx7mDCUcBzr7QlHCSBGQEn0V6kvGz+vxhMYM5g7gxjKGVPOkOtTDTsKy8mIpLphXjcSAnp9+uZEmP2jfixM+FJhx7lJq9PfEF6ON+fWk7feJhk9x3YkzqxEEUbMVdndJFnriU4sbQkcLIy2P5ca2c3yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 16:39:58 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 16:39:58 +0000
Message-ID: <912e3da0-d244-fba9-2991-acc4ea8e9943@amd.com>
Date: Tue, 15 Feb 2022 11:39:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] drm/amdgpu: add reset register dump trace on GPU
 reset
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
 <20220215101228.9433-2-Amaranath.Somalapuram@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220215101228.9433-2-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e09855-b762-4ef0-25b5-08d9f0a1cdda
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2988D2C7F8C07AFEFE3E2828EA349@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Evz5J98OCvMGetqC4gdMQlkm0s4ANxfmyry6HnUr1MgjL8sWJPIY3nYyGtr5H3TPrJmRKWqwEcVIZszIImrKHTUg3lQJa6xdlGfWoqFH0NfnmEhz4tbMLY9srQZaCQR9iXZAyAscqIOwfO8ExA8vT1ndEylMh/cyuGr+HagLsuAVOdxvL3vmafCTUwa/ZYqIlzEbB7n6KCqj/X3l5wbH1L1mABuXTv15CoELgsxqVv1Z2cKxZ610VpoxCU3RR5q6BX2eDjCVnlDsgvYBzMKKDQUuKKNAnvpwAHv+BU9I4mP9bomvRCyKX76ZTNzvJV/FhdnaN7DHkCtWConQqZYbkezOeSEmeV27Ak+yFLEyYHsmpcM1wrDIN4ygffb4tMXDIFhd+qo956vwq/mKUYNl5IcHjbki9x+wtk90T8IvoLbu+2O9mOPMrJnqI+GLU4HKWP1xw4fCSop5mY7mW57kPswIxkScRhspoxbzI0xXErY0XwiLL+W2HfkOaoJxMTnSKwGRXUzejcDhbUkDL9wcT6XuUrurZp58fJ0cjQ48s2hnfB8U9i0ATNu41qGC/MZd8hVEqB3uBOBpTP/b/VaceAsKpk7oTQmuypYIzymafmnLRf4gCuLXEWXSoGRQ6kfXgtrSjgUBvbLbDU9myfa+cjCBOgyV/9Pl5drKy/pSXAQJVYW7JaNPYThLG9WAI20JiCmGRo3rhap8DotRU7suWfdUWZTejB0KELgv4AneIJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(66946007)(66556008)(316002)(8936002)(66476007)(186003)(8676002)(4326008)(83380400001)(2616005)(86362001)(38100700002)(31696002)(2906002)(44832011)(6506007)(6486002)(36756003)(31686004)(5660300002)(508600001)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlowQitWS3lhYXFMR2J0MHdLbTZqNXlRdlhvRWJJc0xGdC9pM0NHZXJCdUQ1?=
 =?utf-8?B?RWhUckxqc1Q4NnoyTDlEK3lkUkgrd2Y0eU1Id0R6YmRtM28zelU3N2pzUmFr?=
 =?utf-8?B?OElMLzd5R1o2T1ljSnVtNDlPQzlsbmtPbEpBKzdhcUdEaTlSQVp4dVZRMmtl?=
 =?utf-8?B?MnRFa0RQMVQxNEtnRUltS2NGTzQydjJtUlgzNDEzWXB0TUZFQkZ3SzV1USsx?=
 =?utf-8?B?Zm9IbUxjRDJkdXZBcytnMW9ibHY1N1RiT3l5WG16aGFla2pHVHMvdjZKaFhN?=
 =?utf-8?B?ZmpEK1h4dU1jM0p6Y01SUnJsTzRKYlpKUFVyajNwZ0xKZXhhdlhkU3R4cGZk?=
 =?utf-8?B?ck9IaTdUZTEzQ0xydm1oYkpTQnRVa21WRjZRVG8rMHRnNTZ4UjdRN2VpTThj?=
 =?utf-8?B?UGFUOTdxY2F3ajVpZWRNQ0kxc2dEUHBjNGd0Q2laMXl4eDhDZml5SmtJVnBT?=
 =?utf-8?B?NmVmam9nd2dvbFhiOG9QVFJQdFZWRjl6bWdJU2RKcjdIRHN2WDhzQUpDaHpL?=
 =?utf-8?B?NTRhZTRaUlNtWEl4Vnk0ZVdva0dCVnhZbkROdWNhVjMwYjQ4RFVOcnZwK00r?=
 =?utf-8?B?R2RpMzNzODM1cDRnQXk5T2U0SU5CUGR4a1ZGdEJ3R0ZkS0ZFTzc2cjZKc0l0?=
 =?utf-8?B?YVVQZzlMalJKRHF6blVmd09pNkFtWkJWWGJ6YkhVcG1yK3B3aVNJNkNmM2E4?=
 =?utf-8?B?KzlRL3dCdU0wZUplaEQ1MHVZTmxRWXh5ODFYZEtMM1lDZ1ZzdzFlUVpYSGVD?=
 =?utf-8?B?SWZrbHdWNXJMaFBvdVNRVGhvdVIrWUp3ZUdIT29lRmt0dGRMRzFSb2oza3Np?=
 =?utf-8?B?aG15SEVCWG1kbjlyb1o1T2FydGJ2SFl5SFN4clVDRUo4V0piQnh4dGZkMnJ5?=
 =?utf-8?B?RW5ZZTJPWHNTV0xuaHVYVjdTUUk2ZlZZTmEybWMvbG84cnhtelZ2SXRuRjhv?=
 =?utf-8?B?cGd3MitQdDRvdWVKendSa2R2QnRBWVhuL0F4UkpBdE41a3M1VWVPUFlQVjR5?=
 =?utf-8?B?VTNERDB5QUViaCtrODc3SjhLQzJIRUZwWDBPR3VYUVVRa2owc0NoNDZteEFM?=
 =?utf-8?B?L2Mwd1VLT3NsempaRUN5Z0hORjFoNG1RY2ExTXBKcTJWeEVVb2h2Vy8xS0ZI?=
 =?utf-8?B?SWpDRGRJNXlvNndVVkFpMFFLUVI5eWprd3Jjak45SU5zNDhOZXplVTREamk4?=
 =?utf-8?B?S0NnOUxxVkhJRW9SNkd1RFhDM1BvWEY5b3dzTStWYzVTRFJYaG8yNWo2SC8r?=
 =?utf-8?B?SmdGVmhOVFU3YzYwbWZZN0w1RjRVN2lEaUZMODdQV09vMXBFNDN5NitVK2tu?=
 =?utf-8?B?RjBlQzNCTGVhYkhwSUFrWTVNSzlrZG5pTFhZa1dFTkxuZVBNY1RnYkNuZkdS?=
 =?utf-8?B?NnFNK2xDRnpwK25nQlY0RENjU2wzTEtURUlBQXNqaFlzbmcxZ2swVHQ2Sjdl?=
 =?utf-8?B?Qk5ZY291VVhSdFdZK1pvSzEzY0tVUXJyblJ1cDAwN2pURm5yb3pGbE0xWEtU?=
 =?utf-8?B?bzk2V2xSMHpTb0RMRUFhbE9GbktQMGdCNDVrUzRYeFFBVlFySXRMSklyck1I?=
 =?utf-8?B?VEZOL0p0MXJUNjI4akJCWlZPdVZGRnE2eG96UGhtNlhZc1BvTTVjYjA2VW5i?=
 =?utf-8?B?RjIwbk5QMksyREhKWHA4NXdtN1pXbW41R3dYYmMzUmZwYkNidmg5RFlPMU0y?=
 =?utf-8?B?ZDdKL1FqVEdKVUQ1UTJzTDM4TGJvSnhzRXlvK3FpNVMwVU51V3IycjJYbGJI?=
 =?utf-8?B?M24vSitkMURZZXp6TWRuWDFNMWk1ZlF3LzVERnVhZ3NyZlRCLzRmdHFuR092?=
 =?utf-8?B?MUdHMjZLNUtwUk9KcmtpZzh2dm82WVRQQkVISlUxdERnS1pQd01MWGlaNitO?=
 =?utf-8?B?QXRGVSt6VU9jL1JaVnIwaWlXT2g1QnpMQTVkNnBIU2NjWGp0VjdSY0ErOFJE?=
 =?utf-8?B?U2ZMejZEczg4Y2RQKzdHRUhnRmhtdWtOZkJ3b2hhZEp2NkJyRGl4dHV4eE8x?=
 =?utf-8?B?ZTd2d3FSRExFdG1wYURNUGdFNEJ3S253Q3E5VVpHN0xWU3B2Y1hMMzAyMGtk?=
 =?utf-8?B?OXBvdTlXMnhMWFJSc0dRdWpMZ3c3ZzQ2andydjNlOVJZbE5PUXlXUnpkRDdx?=
 =?utf-8?B?M2NkYldjM0VENmJhaHhIZG9RUWRMZHV5V2FGUTBnVkJDaEpidWRSZGV0Q2Y0?=
 =?utf-8?B?TWlJT0xwVHhXUFdhRlkxNWFwL21QOWhRR1BNNXJDUTZsZUQ4VFZCdjVHUm9y?=
 =?utf-8?Q?m9VZM4j5Xf/tPQZLbVpoIEP3TnDJJjAUXP6li2mrNQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e09855-b762-4ef0-25b5-08d9f0a1cdda
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:39:58.5381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH4WvuQ/Oh4uHnrbH83A/22LW5v5k70hRhiJkQC2HqUDgCbCOUb/2bq9kClbEcacoJ+YnqqXbUmVcZCdrWRqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-02-15 05:12, Somalapuram Amaranath wrote:
> Dump the list of register values to trace event on GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
>   2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e651b959141..ff21262c6fea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> +{
> +	uint32_t reg_value;
> +	int i;
> +
> +	for (i = 0; i < adev->n_regs; i++) {
> +		reg_value = RREG32(adev->reset_dump_reg_list[i]);
> +		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			 struct amdgpu_reset_context *reset_context)
>   {
> @@ -4567,8 +4580,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				tmp_adev->gmc.xgmi.pending_reset = false;
>   				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>   					r = -EALREADY;
> -			} else
> +			} else {
> +				amdgpu_reset_reg_dumps(tmp_adev);
>   				r = amdgpu_asic_reset(tmp_adev);
> +			}


Is there any particular reason you only dump registers in single ASIC 
case and not for XGMI ?

Andrey


>   
>   			if (r) {
>   				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..b9637925e85c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   		      __entry->seqno)
>   );
>   
> +TRACE_EVENT(amdgpu_reset_reg_dumps,
> +	    TP_PROTO(uint32_t address, uint32_t value),
> +	    TP_ARGS(address, value),
> +	    TP_STRUCT__entry(
> +			     __field(uint32_t, address)
> +			     __field(uint32_t, value)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->address = address;
> +			   __entry->value = value;
> +			   ),
> +	    TP_printk("amdgpu register dump 0x%x: 0x%x",
> +		      __entry->address,
> +		      __entry->value)
> +);
> +
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
