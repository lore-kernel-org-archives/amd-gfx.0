Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD52C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 19:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF18110E010;
	Wed, 19 Jul 2023 19:53:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F9C10E010
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 19:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+gMyvlShaoxo+hWL2mu9P/Kqqi2ZK+CCmFK17CsaIPeij4kICDk6eCv1DsGmK2FqalGMg2k5DcSQ3yJTW9yHY4qdDhXcZF6jaDqEWWVTOG6O2oND553jtDnr5ucqWjNeB/SuQVE7rr4eOFLQjh/T9s1jBS8Oc7iQ72lMJwj/tCZce0p5mc23ldOIZXmM5vNCrhkN1V821sY4iJFxgMlg7R49r+AcFBxZLXKUOAz4Pn2vMd/dJcF5Mrdj0E36bTs9q8aCcqs0ahdQswcmnrd3OAa95VsNJ1Z0ChbpQPyCIXwTwxBsmElVtK82fVSLbFQrZtgBILhsRQ0vGIi/V6PgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiFoh/Yq1feJXZgljiWsJbYYxnaPLVmdcVbm1fFXhw4=;
 b=g+1gwyRCxzmE5/QyqV2Vl3cfsmdat6elzzDW6n1Yl66BHe0InE7Tk1s29Qp7HvhaGviBAIv4lyz5V1OajttkE4Fov+m50urAVIxO3RZgQ9/8R1TBW2Ym67jmmvJhCtTwq06LsMaa4AZniGV1J9sr8zjBrdfHMWCn2GkWJDmzAKPLf+62TOGZEl8FjYb4he8dxpHyaB6UXmyLT8kJmTzJb4u9CQ4Z0wbckCc66wTn/PDsM1xHBYHy0TIGAPrtTkrfYyq0fDh/cDlnWNsWFov5BzKQ2obKFmYwFYB56MFJ554a8a5uvbot0HbV6VppPKHYiJRwT8AOxWPor444JNYwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiFoh/Yq1feJXZgljiWsJbYYxnaPLVmdcVbm1fFXhw4=;
 b=I/A/10XOg5onKtzL0IM8fEzpFQ+q3VI64dUITr73L0ptjP9Agyc9CNo9phCBUTWu9C9Y2A0eCMIAY3tU8THEV3xaqf/ojYfzdOMnliMSMUhbcdXaSQaNZMARgvvwAM5NPwHyhhDvty3qxnT70XHgpTXxisCQm4VzF1gugpYk0uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Wed, 19 Jul
 2023 19:53:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 19:53:15 +0000
Message-ID: <aa08d039-848e-7eb2-e32f-1de9afc60b3a@amd.com>
Date: Wed, 19 Jul 2023 15:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230719180354.23516-1-alex.sierra@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230719180354.23516-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db18a8e-8457-4da6-46c9-08db8891ca7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/0RfEgvzr4IHkOCdZbszjmHnHt9osi5YkNJS/QaFsO+xQAdNBCKWSqk8IjqsaRbG+l85TbE3QW9+R/8FopADYvQhupU/xy+AAz0fvP7AznALJjOOoZ/1/RgkpeT1ezKT8/poOaty5xf25QCauCqhR1l/4cX8d0ippHYbebz6d6R+bD1Tko7EQQVh8R0ueKkBVh4daefS5twpX1htdg03mUScXqh4PHe4PH05/PpznfCXEDdPUHIZh9eTVEwf87sdoyGozZ13xBXtcZBpptAxPL72LYTOCjPZ+n8YIALZi4oeSL0D5xEC93cekwZUOrR36Ct5KjixvVGh/ihuicq7AVQIFIkwjTJnpW86zYioC2qV2GJVnLM0/lU+s5/weD1On4g1M+XWdSinjzYbGQGViawgt9c4ewwJudsmRSJW2nVQ3X3vXtR3Gk5mxfIfAKUAM0qWKcu8Z3o4tfswCmwgbSs1SoyLux0jdCgd2Qb4IXk/d4SduHIDzSwb/bngg9QOTBxtotzo3xBkyNdpKjEmZx65EHWuYJQyjNzyXFgxtSMYqNAYYN8y1dJBpZf6T8YHZ8FDcW5W3sLyx5TYa8eoxXLExsTc1ph3NbcU045DLZeq7PH7RMKxTzsy1EsNWtF7DkMT41G/DVePTVQ2RM7zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(6666004)(6512007)(6486002)(83380400001)(186003)(38100700002)(2616005)(36756003)(86362001)(31696002)(6506007)(26005)(5660300002)(41300700001)(31686004)(8676002)(8936002)(316002)(44832011)(66476007)(4326008)(478600001)(2906002)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Q5QmVDcUpKK0gwYTlsdUc3alc2SGNUZ3BENEFrMFVOb0toYlJTS1dRUlhF?=
 =?utf-8?B?SVEyRCs5NGszV00vMk15enhUNFVtQVNjKzZXR1AxaDVJK2I4Q0RrblBBVk5m?=
 =?utf-8?B?YWU1Um9kQklqQWNNbE0xRzhBWmlNVUFOY1pjNUNpWTJDaTNCWkthOVRweGFP?=
 =?utf-8?B?bXlhU1EwUlJTZTcvb1Z6U1pURWZyMkhwa2V5dE9RcnhYbmN1TUUwc29kcFly?=
 =?utf-8?B?bGl4RExVM2dZNlRsWVRNZTlmYlNicWZYMForaXJyRW8vNE9yOFQ4cXNqaCtM?=
 =?utf-8?B?clJBMWtPb1FaUitsSEdzK0NSVHA4cW1Nb1VqNjJ2YmlTajVEdDgwUlRJR2Nr?=
 =?utf-8?B?NmZrWjVZem5VZHpPaURaRktxS1BQbUhKbXp3Zk5uTjdZVm5KcHJ5cmMxcTJh?=
 =?utf-8?B?eGgyYjkxRUtPcXhpbFJnUWdrczNxR0M4cFZWREF4VnVHN0VubDBCUkFRbk9G?=
 =?utf-8?B?TUZJY2czcXB6d2FUMVFNR1V1UEV2YmxUVThUT0oxR3hZeG1KR3loYzFHTmsr?=
 =?utf-8?B?SUwxN0dndFlmZXZ6bk5STktVUEhvc2w5SVhFUGNBb0FaYlpCRGswWC9Gb1Ir?=
 =?utf-8?B?SDNqcnJCVWRwTTZTMGloV0hzWmF1aExsYkJFMy9UQjIvM2laNStVZHNSanJp?=
 =?utf-8?B?RTBrNno5ZVZCeGNFU2VtR1JCaFZkOS92Z2dBRjBJOCtneFpwcU9sT1ZDb3hQ?=
 =?utf-8?B?N0hzanBuNng1U1lXd2xMaUpwUDMyL0N2V1k1ck5Ca2EwNnczSXFpODhuVHdt?=
 =?utf-8?B?SGhuRUM3d3pOQWE5RGVoZEFTWWRYditubWhHZ0s2RkpjdXlnYVNvY1B1bWho?=
 =?utf-8?B?T1B3bDJpOGJ5RnZiVnBWcVd3YlhuWk0xYUE3bFNXdWxHNXQ1eVNwUDhQWFNr?=
 =?utf-8?B?OHlhRGpIYlRlT04xbWVPY0NpTGkrZWZ1SEsyTHhRVGxUNm5UTmRMakxHdU1s?=
 =?utf-8?B?Ny9SWDZwS2JDRFZNdW1NeVFHSFIwMFpvODVSbFJNMTVIN1IyRGdYaG5HNjNP?=
 =?utf-8?B?Rkh1RUZHY3VpN3Bmc2hUbUlEdURka2YvTUlyWlU5UjZ6bTlGMlBwcHVyUS9m?=
 =?utf-8?B?K21Qb01KQ1JVMEpIVG5JVmRvdWkwSElPb1Y4Rm94eU5zN1ZjMDhlLzluNUFn?=
 =?utf-8?B?MDErc0pFcWFsYkM3VUkwaEVnUXo4V1JLajVhajh5aUNYemtKTHNkeVg2bzJQ?=
 =?utf-8?B?bjJkMlFZWTdnUmY4bWFtR3MwQXZ3R3lvZWVyM3hDQzJmUmI1MlhoLy9UZXpy?=
 =?utf-8?B?cS9FdzhJV0plRlNRdGVreVk5OXkxRzRGV2tMekxtVHErakl0RTM2MVpnZ3o3?=
 =?utf-8?B?VGdoYzlML0tmVHJlN0pJd05PUmZkay95UTV6Mm0yRjZsMTQ3YjRsRGZVZS9S?=
 =?utf-8?B?OWU3TWY4bGFqVkxDVm9jemNHWnp5azE1NGVXUmR5VS83bWVuaXViQXh2b3B4?=
 =?utf-8?B?YTF3M3Vha2d5NnNjTWdESjcyc3hrNFdTM25oUFJlbm1TOTRxOHNlaXFRYTgy?=
 =?utf-8?B?MHUvcFMzWkcwSW5DR1JtNTZxakU0OCtIYUxURFdtaEIvZEdBS3BaTXhNOG5J?=
 =?utf-8?B?Smx3ZTEwL0YwaVlDYmpmOW1hbUhSMGNWbWRpdWNJcnFjbU1wZHRQQUNPL1Q4?=
 =?utf-8?B?aXBpR1B6b3dVQ1JTL2FVRWhURTV6ZXlybVJZcUhKZG0vVUQyaGFxYXlCM3Qy?=
 =?utf-8?B?OFhyc01OY3llaHhJSUlVS0V1T25UM1ZpbWJaZjNFQ2EvTS9vbjlQd3ZaejNK?=
 =?utf-8?B?cTZuaEhJUnNOR2puNnd0dkRYQWRzVURnaXQ2U1hTM01ZbDIvRWZJa2Z1WE9W?=
 =?utf-8?B?MXlaanJabkxZU3o2VENwZG16OStpV05IZzlKeTFYbk1KR1NlMEJYelRvK1RZ?=
 =?utf-8?B?YlBwOWNmS0RrLzJlV21PMmNjQlpTRXRmM3ZzdGlzMUM2b0tkMmNpY1dGOStB?=
 =?utf-8?B?RXdaamF5OHlhSW1xVmc0VkJ6UytBN1NvVDBQTERCdlovWktoTHFZQnJ5NURX?=
 =?utf-8?B?RldKZ25PbStOT01sVVFWOTVkR0pKb21MaHM0Wm1PSzZNaG9LUjRlQnJvZW9j?=
 =?utf-8?B?SGZ2cXFuNnFHenVwVUdveEpUdWFicWtuRitrbmZRQzdLaWdrd09Hb1VGY2p5?=
 =?utf-8?Q?dhoSafGffg2gbO7DitMZgO/Ga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db18a8e-8457-4da6-46c9-08db8891ca7a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:53:15.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71YA694WMDStr0HeL+Ur+vnKfEdl1fQ+sReJui0FyLFyxWm7rVlaHpf7LIFyDTMjZt1YEautCt3sGfGEEdma5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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
Cc: Philip.Yang@amd.com, jakub.kurzak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-07-19 um 14:03 schrieb Alex Sierra:
> Set dynamic_svm_range_dump macro to avoid iterating over SVM lists
> from svm_range_debug_dump when dynamic debug is disabled. Otherwise,
> it could drop performance, specially with big number of SVM ranges.
> Make sure both svm_range_set_attr and svm_range_debug_dump functions
> are dynamically enabled to print svm_range_debug_dump debug traces.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Tested-by: Alex Sierra <alex.sierra@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 479c4f66afa7..0687f27f506c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3563,7 +3563,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			break;
>   	}
>   
> -	svm_range_debug_dump(svms);
> +	dynamic_svm_range_dump(svms);
>   
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 21b14510882b..ed4cd501fafe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -39,6 +39,9 @@
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   
> +#define dynamic_svm_range_dump(svms) \
> +	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
> +

This should be in kfd_svm.c. The function svm_range_debug_dump is a 
static function in that file. This macro is not useful outside of it.

Regards,
   Felix


>   struct svm_range_bo {
>   	struct amdgpu_bo		*bo;
>   	struct kref			kref;
