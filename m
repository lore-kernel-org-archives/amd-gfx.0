Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 20:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AF7611C8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 20:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75AF7611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7EF16E249;
	Fri, 24 Sep 2021 20:40:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7035F6E249
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 20:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuigF+9s6VBTRG71n0BdY5WRibjaiYc+aE7HSMm7G4nxv3ZR2xN4K/E5N8AAsTZxSONutPDj1MXpPsRE1VuNpkfxY0IkrHufdkKHkOwzlX+QS76OkjS4hNP8TkiFY4c1yGAgeYuQi50JWXBCcHqFLkQsqLmzhIQpn+DfcCegfXU7reFNcR26TUPfJwtGb6VlUuo+PpUg6ltccRVTuqKbzR7kJA4GXHQUiBRKVK0SFtCLVvvjROeScQy3WMO2Yka1pC0O77VVM6lGf+cTWH7S/r7QheZWLodMQJC4WFWwmm7XrKDIg/a25DgNPfr9nHLJr6s2piwV4+5u9Uapk4teuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8t/RWov/QcjtrcZqRQPs+mg5pyOyvCP6K03MGj+QKts=;
 b=IFcXECRvErENJNmKObBbI9UGNOcDAJ1UUVVfnSRF/zuGcI/0uW9c4Ve0RVbkOdzUqR6Fc9Fs+zI+mUm4bLlMiriOlkuf0uSWEARE225x5BA/xQHn+Jsl+qS/bF6jiUuga/w8HA9/X7E9S8fTODo1occ/JlGpFuYkjLnH25JXfh7pKuKaB3Az/h5Y91r8WMhHSFF1Y38Y5UDj3agKUTk07LOSI/fDhFM875Zby6MiudbRaIy4Nd1naZSEgIDp/SrarptiReMy3Ui2Yrm6C4lc4GbndAjgLHZ9Pk3da5IHnBb+fiUSkklGOgcXR1aEsAfradktwUw+Mb5VgTaW53Nqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t/RWov/QcjtrcZqRQPs+mg5pyOyvCP6K03MGj+QKts=;
 b=1SZys0xHJxjpYAwosGB5b3LCVJnmHHIzMA7L+8GoHacTpuClfLwFjqpqLZmd06vFJNrdJ5H6dmNFctoqcWUoR3p1rafS/XjQhC77Phpm13AhKEFnRMuON228RpbMMpPLig9jbXQBUtjXLzJiLKfv1GTP/jZZ/55Lsxmo0dJWIWs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 20:40:28 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 20:40:28 +0000
Message-ID: <9cd8aa3c-5015-08de-6812-6e1f0c1f412b@amd.com>
Date: Fri, 24 Sep 2021 16:40:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 30/66] drm/amdgpu: add DCI HWIP
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-31-alexander.deucher@amd.com>
 <ebe17aa2-bf8e-c305-e275-d80e1f01537e@amd.com>
 <CADnq5_PXO43XBRjCg99=CqUQtYKbVfF7b_8h+K+98N=yP7HASA@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_PXO43XBRjCg99=CqUQtYKbVfF7b_8h+K+98N=yP7HASA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:e4::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.42.68] (165.204.84.11) by
 BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 20:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ee097d-dc98-4a06-6535-08d97f9b8b3c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54271FC44227C187B351DC8F8CA49@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWfSblHPCwZm2envcb8QpTF9n/8UasNN8/xbg93QnT7jsgBSvQ9QgmSdj5EY/N5cHpVfQ/WTNVrmFm/D+Jj7OM94ik64dShJoaiXlfh/MHFNNf1Rcvp9n4/p3qcDzcVchiJewvpPLZht4Nt4erT+3noHTlSpDjqnhQBrxo5Opb0fdVAo6+TN2FntKAAIZAeoVs7mPjCB0EqhfAQn3527nU1N8roCAGGKc65AjKSRrFtaaOe160VpH6HWhz6FophNiNG95JaW/nHdHZ/u9QweLKh3DiutaYU4IUuPxZy/WPzu/6MVmwwR7xQO+8wyigxsfJHHguMaRvrC+BvxKwPUucnbI7vgUW/ZUb++ASxguHJ9rpRx7KtK5BvOAOhY/Iw6vSoPCmlSClyMRDwVAjwTByX/u3jwRWgXaQDRmAAl+ptpk0ioK54BIeA1jkESWd81p9Egr4f1P+DTpIW9GWzyRZswWO6wBzeZAW+ANyFunCiusBZ0d6KvDKhkc8jSjGUpEmbSirKwnFx32oxBHkW1rADg17rAWsa1P3fl7H+W8Kh2JKQuOpibF3SliySWBmuklviEUx4tozeYblXN+dT9qcdysvUGLSl28LtX8lri0E9RIAPlsG+8oTyJaakSPCRIdYzVbwHPG2TSbqk+2rraYy8mH0pGaUh6z5wuCwLmMWG+NLVDNNmAlKZMaIOYJT9SUICsW2CnnydBEukD40hZ4U41hApgYEk6niDOJZYdg2uth1UaMbcwPNFSYDApLGqr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(31696002)(186003)(54906003)(44832011)(316002)(86362001)(6916009)(36756003)(2906002)(83380400001)(66946007)(66476007)(66556008)(16576012)(8676002)(38100700002)(508600001)(53546011)(2616005)(6666004)(8936002)(31686004)(4326008)(6486002)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBlQmdKNFdCWVM2eHY4V0thTUNQb0RadXBYUXloK1grSmFycHlCemEzelNI?=
 =?utf-8?B?clF0R2RoaC80ME1GK0N2bjhwZElrRmdWTGxaVk1TU1VtcFh1clVoRzYreTEw?=
 =?utf-8?B?RlRyWDhWTW9BR01RVk53NElQSXZBRmxRb3I5U1NkQzdIV3N3NytMQ2ZtT3dZ?=
 =?utf-8?B?eHcwamdlcE1IOG91NFcyWDJnclcyUUM0andnSTlqNTNLUjVNUzBCM0pVTUlM?=
 =?utf-8?B?b1ZVd3FPRU41LzUyQkhVbksyc1hSa1VGQm9DcTFoWnZBa0dFRVFMSHZIcnZT?=
 =?utf-8?B?Y09sREtiOU1Cc25RY21hV1dHV3EwdTBmb1p2OHdIMkJsWk9xSFRsU3R0RG8y?=
 =?utf-8?B?L2FsSkQ2bXpNZG9QaDQvaUNmUWkzbHBEbk5oYlloWm9sTGRKWElrdFREdGxk?=
 =?utf-8?B?aW9LWS9hTG92MjlXelNxMFp5eER0cFhBYnJrWjh5TlNlVmJvcW9tRExDQ0I5?=
 =?utf-8?B?aG1weVVPdnNjYkFEbWNhYS9TOHZsYklzbGlPTktVS2t2RkZRVkxOMnp4T2tr?=
 =?utf-8?B?UDBnQmZCcjlZL2tERTdaNGVZaEZ0T256VXpiYlRzNm1BNmgyNEdTanFoOUtn?=
 =?utf-8?B?VEh3RnJxZllRNDhVam0zMEhDaXRqMm55OTdXZnJxSTNONFBhMjRaSzBvK3Bu?=
 =?utf-8?B?S0dmVzZPM0k4czcxQ1R6bCsvU0p1Wk9iZXpzVEVBMXBTb2x1RndaWnB1endM?=
 =?utf-8?B?a3RUb1NDY1pZVHFzTDNYVmFLT2ZweUpPV29MTWdSVkppWVg5Vy9Qb0tZd2ZW?=
 =?utf-8?B?TUNrUjk1ZFhxYzhNdVVWd1Btb2lYZlNtNkI0QnErVjdheGdwYUVmL3FVbmxM?=
 =?utf-8?B?SnB6Mm5DeG04RnZMdWZJYlJ5YlBLNDhmb3dWOTRqbnVpdXFvMmMweitzeWI4?=
 =?utf-8?B?SkNyVVgvaDBYZ1lnbUpoaE5scTYwSjNhVzVwU2hrd3hOWmNHTmZRWk5WWkFM?=
 =?utf-8?B?WTV4ZEk3bjdHSGVyRTNoSVhNMHVzYVo4TG1iQjhvNHcyL0VpUlNRd3ljZlVI?=
 =?utf-8?B?c29wZ0MxV1NRNWRGYWVEc0lqaEVycjZwZ3FvaDRJRlpmSTBGT0N6ekpOWHJ0?=
 =?utf-8?B?KzVPU1V6amVaQjVaSi9lcXN2dU5tZ2NVTGR5ZkMyOTlkUFZMMGZmWmYzOW5w?=
 =?utf-8?B?ZTNhZEQ3ZWZQZHc2d280OHR5OHRTdy83ejRWemVkakVoYVpETDB0Y3Vhem15?=
 =?utf-8?B?NzlhcWZZNlM0bHhpRitLVUFTSXhPYWh5aDJMK2NJdUFWMVEwcUlRMDlybW91?=
 =?utf-8?B?bk1xa29aaUY4d1JhR2ZPaldQcWxNN2IrL1VuaXFmQmZQYTZxaklIUnl6amVD?=
 =?utf-8?B?NmxycitLR0ZEQS9IK2FyWUxpQ0R2R2FWSVJKRnY5c3JsbXhGL0pKZ296WFhF?=
 =?utf-8?B?bnpEamQxK2c0dCs3Y0lJN1V4Z0I2L05PZkgvMDJXWjQ5dlM1MDJjN3hBbjNh?=
 =?utf-8?B?dkhRZmFXamFPbTVXTDhMQkhySW5SbHhla1crUytKWmk0ZmVnTDIvT3NhcU15?=
 =?utf-8?B?RTVBbGZ4ZnoxRk1ZS3FUWW5mRmJQWDZzOVJra0U0RjU0Q1J0OGZxM2tjVWJP?=
 =?utf-8?B?aG5XcktUNER3NlhsMkloaVhrOWNOVGxxRitwZWRTK1lsYkVjWE5OTnBuT1dR?=
 =?utf-8?B?TnhIWkdhZWxMd3ZTZy9xTW5VbmFLcjd1S3lLRFJWdDZRSUNWYnIxNDhBbUtF?=
 =?utf-8?B?a3lMRnFlMk5jdkcydVpGSmpUVXJvYUc1aExDbmsvRDJZTWVLTEhJUG5EejdU?=
 =?utf-8?Q?ANVr6f997+ZyMwwQFoHKxCZaTOonS7Fw486z3x3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ee097d-dc98-4a06-6535-08d97f9b8b3c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 20:40:28.4326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hz4nFYSPnGdvmPA00ucxl5isugBFEnrZ/ApiXdgXyRj9rcxR/ubU8laGbdmCq/YcR2rpomEGLuswsm2fRNAmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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



On 2021-09-24 15:58, Alex Deucher wrote:
> On Thu, Sep 23, 2021 at 11:43 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2021-09-21 14:06, Alex Deucher wrote:
>>> So we can track grab the appropriate DCE info out of the
>>> IP discovery table.  This is a separare IP from DCN.
>>>
>>
>> I've never looked at the HWID stuff before. Do I understand it correctly
>> that DCI_HWID is for DCE IP and DMU_HWID for DCN IP?
> 
> yes.
> 

Thanks.

>>
>> In that case it might be good to rename DCE_HWIP to DCN_HWIP to avoid
>> confusion. Ideally as a prep patch so as to avoid excessive renames
>> later.
> 
> The names align with what we use internally in the IP discovery
> documentation.  I'd prefer to keep them aligned, but I guess it's not
> a big deal.
> 

In that case it's fine.

Patch is Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Alex
> 
> 
>>
>> Harry
>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 8df4be702870..815db33190ca 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -756,6 +756,7 @@ enum amd_hw_ip_block_type {
>>>       UMC_HWIP,
>>>       RSMU_HWIP,
>>>       XGMI_HWIP,
>>> +     DCI_HWIP,
>>>       MAX_HWIP
>>>  };
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index 048a08d7f480..6a993043badc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -149,6 +149,7 @@ static int hw_id_map[MAX_HWIP] = {
>>>       [CLK_HWIP]      = CLKA_HWID,
>>>       [UMC_HWIP]      = UMC_HWID,
>>>       [XGMI_HWIP]     = XGMI_HWID,
>>> +     [DCI_HWIP]      = DCI_HWID,
>>>  };
>>>
>>>  static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
>>>
>>

