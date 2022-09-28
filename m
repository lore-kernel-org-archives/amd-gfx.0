Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB6C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A8010E50F;
	Wed, 28 Sep 2022 17:39:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D0910E50F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifQQilBeJuae3Q+NfMq6L8W9NGMN0ho3HHJvlEwEwpWfE69KNLfafbzaFP7v69+NUuM0QINLrafxAVdIrTxK3JFZk/HEXvXKotAX/Ac+FuL8ZMFubYowhy+CyPmfiu2pvcYHy6ZAFk59OVpaDqfvuEK4amQEjSTsfSVrPv/BTVRokXltK2zFROcXdAiONKGUtrFFqrD7hdeNFazjs5TorZEJu2BeZdtMZQ8ByMtD9dJDCyOsmkPZnMjUahvcr+PMW+nBeXc2dPcVAYkMUrfi89x/ZNq2Q+D6JNzpnsIOcgX6B9cJv5BRDLiEworhL3Sd9XdyoK7RHgAwQknWru8rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwv152jYhqwPzCGxT/tLeIjWjSAlQf4XlBvV+FLEYSU=;
 b=gdkD/NR3yswNJzmoI/NECC2lditbkneJD075muCDtnHTpw9fNCieUYv0ETYcH++q8DERgqKRJ7hKODh4xAFWtP1atpnkPwKmXbF/woTMfhWsie3Go555ayD7aKlwlmI9RCtol1Fu1PZ4257OePPkDXpZNk+X6SmlBxruzPQB/IrP4/rshis/nYsqZDzg0HlhL3KMohKI0J1Xiq+ngmMzgn1oiUfm0dMxZsJFYKNEN5+lw2uP8jx8oi+jDjE6jI0YCHy1pCZOF06jtlCN0oBSus1/i+hsGbnESEHopaEKoLUtmg6+QNk8LQLScaoUDIfQYnFoyL7+n7vhB0L5ZBHPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwv152jYhqwPzCGxT/tLeIjWjSAlQf4XlBvV+FLEYSU=;
 b=cMrwHh2T4YlsyaaQS7Qlgix/rfTJM8uKLF/BT8+xh4J9sHSdGGf9J60mwWl1N1XETotgFTgJJdW7/4debb8+k6hz4Lh3Xe0cM9HS0mCgkKVbZ9inFpa3ifU9s8NeeeiM0BHGkNchgjpsSwWQKKUHN+AayMSBvQFXZBwjcpCbMFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Wed, 28 Sep 2022 17:39:42 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8423:8031:a9f3:20d5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8423:8031:a9f3:20d5%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:39:42 +0000
Message-ID: <84ab8a37-1341-67fa-4af4-72963bee9744@amd.com>
Date: Wed, 28 Sep 2022 13:40:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Content-Language: en-US
To: Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928173733.12457-1-Vignesh.Chander@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20220928173733.12457-1-Vignesh.Chander@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 7595d992-8af3-4f90-e340-08daa1786cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYwtgzmBCAKvdKNtGWNre7YTGgy7DNS2o+zrQ5HsmtDukCFvY+b2fRUSY3EE59NlLa98GwgsMwvOI/SIQxi3wnph0yp1xf1RPTOACDcrnHi2UgCLtdl8TJajofPPGEu8lNw6dJJslU8iy0OTjtZp7ZbIE+j3i0tPqCK1pfO5cSc5OKfh32zgjCutxxlpc3fteBd5XXg7xpWAvoZgBCpkwKKImH+kHE+juOBVDpzWY2k/UtwyM8ACCl221BUzitPqzfbYp04O8H5fq6BaTjiezO2r1o3Q/w9/dB1LnzidIuVfErwtIDNgO8A94CFQI6Hkkxob+UW/iheth+XrQpME/RvhuTjBo/T2YE3JNp2EeJs6lDbkcCUe1/AHgMkpdRYJhe7UlJjbtJ4tDuLQx8Wndwdex/nYF+mxXNYMwe34sdVHlZYOvctsvzq+Se31HlQAdGucmr6vK/d1ud/Y6FX8w9NyUwYDe2oTDsxfd3UR/mGgZGoOYkUKP490XWhiNfD5eujaouJX4Hk6q3eV9eRXG8ABbJKY8JSoy75rgh1qqJUmXl4obxAVYvps8UyWQ0cT9a64imt5rlbtJQaxLMiYaWxSuaL0qVoiKDuvtiOzfH69bjdvAqAvgGLW6JFByZNdJ7zr38Z2uII1DonMNTn3EF48OA7a4Ffr5qdZZgIFx3FpJUStpwN44NFoZrx8dkbskommR9OEnzOhi1zXqKXtSiL5fhy+DCJZejP8g7Iih+XVf438pg3sVpEIh6fbG18rUX4//HfnGQzxeSW6JgEOpCUTkYGW5C7OqYZqfSpbZns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(31686004)(8676002)(44832011)(66946007)(6506007)(26005)(66476007)(6512007)(83380400001)(66556008)(4326008)(53546011)(4744005)(478600001)(5660300002)(316002)(36756003)(8936002)(2906002)(6486002)(31696002)(86362001)(6666004)(186003)(38100700002)(41300700001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG0yVUJYV01DZTgrdTB4WU1XenFiK0kvSU93QnZieVdMMEpleTdnU0oxZFp3?=
 =?utf-8?B?MUVXUTE4eXJEYTdGVjVVZTIrbDRRcVppeVNLdUZsU213Si9tRkRUZFN1YmFy?=
 =?utf-8?B?eFFXL21lbER2dFJrNVVXWkNDYjZSa2RGRG8rcXRYaTYwdmRSaFcrMnpTWEcr?=
 =?utf-8?B?eUNVbnZ0bHJVSmhJb3liejNEQjRiNytDVHdLT3BaMG5JbDR0ZEdjVkNvSnZ5?=
 =?utf-8?B?aFJqOFU4a2E2OElWWE9tWTMwZ0p1MFJBdVIvZXFhaWdqd0hybmJZTG93bWh3?=
 =?utf-8?B?bTNQTnZBWW1TbnNPOWZheVB3YlZKZFQvVzRKUlIxdWtYVWR5OGQrM1lvcHJX?=
 =?utf-8?B?MzQwU2ZoOFdVYlZhcEFPSUpMOWR2Mi8vd3phSEo4MlpuSW9xd0cwaS90dkF0?=
 =?utf-8?B?YmUzL3lBM2JTVmZTRThPQ2hOSWVkMTRFYTFTUDlLRlNIVlp5OE9wU21EeUlu?=
 =?utf-8?B?SEprOThLbFN6d2pMMHBDS001S2xEbW9WelFFclJTTkxsRUl6WGhwbUVYMHBV?=
 =?utf-8?B?YjVxT252SEJmU0QrbFpKUHJOYkRsNlR0QXJ4bURxVnU2L3VzUnRsZEQ2VCt0?=
 =?utf-8?B?bFg4OUFlTk9SbHUveXlKZVpBZWFmSFdhdUl3T25XL3hscHFqS0RSVXlobHJJ?=
 =?utf-8?B?eURXdk4zLzhwakFRaDV0STlUcVVaV0pXdmFtWFpKN2tlUHN4L0laa0FQbWlM?=
 =?utf-8?B?WG0rdCtaZk42U05MM2pWaE93N0NjU2o4bGxGUGszTkx1ZkV3dkl0dzhGSkNr?=
 =?utf-8?B?YnlYWHA4MndUOVVwL2xTZGhkZ3NzYSs4VG1vd296a2t3S0l1MUJCYkdKR01Z?=
 =?utf-8?B?d21tRkNHSVRycFZjdUhJdkNROStaang0a3hSRUhyOThMeWRoek9yck5SZXh3?=
 =?utf-8?B?L2Z5enpSZ0lPUm1UNVQwbHFUUytmN2xXenM3R3o0QjVxOEUzY2R0M04waGpK?=
 =?utf-8?B?M0d1OHRwdW44YTU5c0YzbFdxUTRRNWFQc2ttRld3bld5TDhSNituaTg3TkJr?=
 =?utf-8?B?YVVrNTJ2aEUzQjBIbmZoS3JiVU03d20xeFE3dHFQR0szK2VGOFlHdzYwOHph?=
 =?utf-8?B?aGIwczRhbjZsUmNRSFlCZzdtZTl0Ynowc0NjTzFEcDFQY2Z0TEZXZklNUTZo?=
 =?utf-8?B?b1c5UGphVVpUMXFRTm5MN24rd3pMUklkeERVZ0tJVFZleUswU3FIWE01VEJX?=
 =?utf-8?B?clRCV3lXWllkeS9mNEEzbURhaysrM2l3cjY4ZGdhandtNjZZQ1pPbkNKeFY1?=
 =?utf-8?B?UGNkNE1qdDk4TUhvMXdwYk5EVWlnLy93bE1BVThJVTBNRllnTG90SUhENTBZ?=
 =?utf-8?B?RGZpR3JnVXAwOVRUL2p3OFZDd1ltb3pPWEhXV08zWXU4dDUrWkx4WnpnYndE?=
 =?utf-8?B?dldDSFZRbnZuUnJGb0VuTTViZWpVOC85MUxJWFh0aFR3TXpZdTEza2VZZG1Z?=
 =?utf-8?B?d2UwM3pkY1RHS0xzMFBaVHM5bndOWTlLYjl5MHVIK0hOZlJzSk9LWGxOZ1cx?=
 =?utf-8?B?RUp4MGdOcDBXNEtTelhlV1JIbXovY25kWGgwalJjRzZkOFRxOUc1eTlHZ2tN?=
 =?utf-8?B?SmdVWnZJS3l3Z3c2SDJITHJNQUw5ems0N3ZyTWU1K05hY0dMQ1BSbzlOdkJL?=
 =?utf-8?B?Vlk5VTBGM21ISEJHVGNTTERzV29QRmxrN0ZDd0hnNlV4V3IydVRQU0oxNHV5?=
 =?utf-8?B?dGF5OEJkUzBDM0UzZC92eFlKWVdnV0NmVWVtOVYzREVjRUhFeEFLcWRtQ05a?=
 =?utf-8?B?THEvbUZBay9HSlZrZnFEaG9neXgrMWVyaHlxOVJMMjJGdUNudHA0RCtJZEpm?=
 =?utf-8?B?UDBjNGk4Yzl1TlNtUi9aR0VnS1hXRWRsMkFoRGNXWitkMGdoaGdNTTdqcjd4?=
 =?utf-8?B?NHByQnVLTkNWWHFDOUw1RzFLWXNtcGRsZjVLSFpyMjQ1Y2hSQWxnaFd0cU1Z?=
 =?utf-8?B?elNDOWUwd3VQYkJ6U3NUN1hraWpMVCtYTjhDdGN2dERzSnZ2ZmU1M3VtR3Rp?=
 =?utf-8?B?cTYyQ3d3MmJ6V0ZmbW16Z2RaeUpnNm1xZHkrM0Nlb2JYS05nbVROUDlVUDhI?=
 =?utf-8?B?bFVFdTJQMldNOHM1Unp3RDAvWk56emI3K2lIZFlCY0RBbWtvSHhINzgrVm9O?=
 =?utf-8?Q?u3tl1atYNv+aLXZXgVb4myR/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7595d992-8af3-4f90-e340-08daa1786cdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:39:42.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aHq3u03yNxlk0dmduvybmGE62wjLFoAPZ6vuAMwPYj9A2ZfbltpfodNmMBx0ZOV4ObIX4tOMyy1g0HYN+wIaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-28 13:37, Vignesh Chander wrote:
> Change-Id: Ifd6121fb94db3fadaa1dee61d35699abe1259409
> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>

Please remove the Change-Id and provide commit message body.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 47159e9a0884..80fb6ef929e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
>   	struct amdgpu_hive_info *hive = container_of(
>   		kobj, struct amdgpu_hive_info, kobj);
>   
> -	amdgpu_reset_put_reset_domain(hive->reset_domain);
> +	if (hive->reset_domain)
> +		amdgpu_reset_put_reset_domain(hive->reset_domain);
>   	hive->reset_domain = NULL;
>   
>   	mutex_destroy(&hive->hive_lock);

-- 
Hamza

