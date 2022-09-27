Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171ACC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8024C10E3B7;
	Tue, 27 Sep 2022 14:50:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7BD10E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGdeNM+bGSWd5zcIL75EwQppyDGxm60LH8at0NkIWeCfR1BoZBASOpfUpTElVF5V13fYzYLhlOys9zDTM3XRVJ9S2K0n6y49jRH30ZmVECgOiLdFziJudHMQo+VDSAsd/R2G9czsZbuzFr5npxO1UtwsGDsmclfaecJ68SGEZ0Y66edNE4mz3t/E2rMzaHdFvQe2FF2ngL/ex55QYGlyIcCkU9imGyZkfcJqTxR3FFmNGHeE1oyady8FqInXU3zc+o/eHs3YNuJe/DH4B6Z0A95nhUJhi7CJauq8A5J2axvY5qwBt5fayMmfc/46rqUDhny46AJ3oRiFqfvT8XeFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzD0t8ha9q4+u+pvApA1gvhXJR8lGkSuHTlLV7+UMO0=;
 b=Ffx4K8t3kC0diVGmzNtIyCeWLEMCaAsKapQhOznf4dQtbSR3ih5kbLpkYbU0rMIA0Ecd09eypYBsYVD6Wtcsl0WgUdTtiVO1+eR21kekoJdiUNmEo96QJjSubmckR8HCES2vYwm2IFALHm2/gnljLNzZSAliG9ZjNWAZj55FtdY7Hfq6wCY0ujxCU6wDbl6RghfrsKYZjNnJe775eOIFKHV9zD7mGzg1Cka7pgbLszZbdz3z8SMgQifzNRpJM0bQgQpTFvBQVma/c+X7r8an+WCXuscEvlAPMeGdgWRSvZrxEJSpRDW+4NUiTeYt8xmzOw5XVZgED5jnRzdI4Chbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzD0t8ha9q4+u+pvApA1gvhXJR8lGkSuHTlLV7+UMO0=;
 b=mB65UXxo5iLtYvSGrKlt7n65OYJCinAQoB0whJQJFirPEatCORN8wcojj2jQcd4zxFpmD7rnvfGl5lguf67JeLldTa4UZ513e8GtxXHnZayNSEFCb94Tu6Oz4pXoEOi9ahaOrnCqY9kg/ID/aYm6I3PD1IHBHmu908gv3ZDumPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 14:50:40 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 14:50:39 +0000
Message-ID: <517b06f6-717f-8201-1a0f-361b74ead38e@amd.com>
Date: Tue, 27 Sep 2022 16:50:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
 <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
 <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
 <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
 <0aced831-643a-f3db-eb71-6129d9ff008d@amd.com>
 <35e717d4-513a-7b61-9e22-6c853dc8afa2@amd.com>
 <7fc9db1b-9ff3-6102-d632-216976d1f595@amd.com>
 <6dbc17c2-729b-e3de-1b94-4b800354e816@amd.com>
 <76175d88-be18-3ac7-536c-96ee527c5f95@amd.com>
 <38334f83-a4ad-2a53-543a-302d174950ae@amd.com>
 <2c5263e5-c0c9-57db-83b9-eccda2292c14@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <2c5263e5-c0c9-57db-83b9-eccda2292c14@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::35) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df01e27-fb56-4b52-0054-08daa097a511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2o3KFjrbzrwh9Cv2XJUyGswHn79phMqWG2EE7XhZS+8+O/W/GdTbk1uo3CZv27F7I+r6Ou/DkIfNixRi6vM9WiPPCr9kf/4JVF3aU6esyZLXnMNWxQR/+MgA/tsj9Gejg9jDKsON6/rvqZLnNLqgcEB9S42dSGMiJThvO27nYBbcjGRptxI8c5v9PTbOLlGVH3l5fQoguNjqzeFyCAU97/0PMPw9wZbRoYJUUYbiLOWGqYy3/pdKT4vPvYBs/pEmgR0NGM5LzTF7I3Mk2iyqHw5fQectmAWF+JAFeQH45+IQOnpVC5+zrd5II8N/NIvqWdKdOiIs0buH1C6FrVb88XT01x1p+Or+91w1UpNRGHefrjLi+zW24AbE/nDhEa1DQt9HMUgmONpchWDedxj6FYRbloyT6722IsR8Hp1wqCZV4ano1VnPDCtMrGSbeEkPkaThdGnCyXIG2EpvdgaY1bJ9/7Q5uLUYRySvbazaGmcoKmQMlbtZC7ZwRaUpFXKTIcDSHHWT84y/GoYGaPixPWyjAV19WrpsGlxtiPS1nKD4bBLxU7gebWujIZekhtXEOyvmHLiKq2uZaNkaPPje7aHQzw208i8j06AUCKO+O2VrGghRUOwFlRuz6HYIsq6mtvtm4cKzh7CyWd3nrPuLVEBrVg/oJsatch+y7rfoGrx6YXmWG1jqj386VE5JIe//ifVYgJ+jlwFo/TaQ20uwdE8lqlcT0S3Crt9qPmic8px0LNY7EzuMrJk+QUCPCIR/93BY+1UOkmpFiJaowh/Fh2uTNj/o1dRGHp3TjiLRkEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(83380400001)(36756003)(38100700002)(66556008)(66476007)(8676002)(26005)(8936002)(4326008)(66946007)(31696002)(30864003)(6506007)(2906002)(41300700001)(5660300002)(86362001)(53546011)(6666004)(2616005)(6486002)(66899015)(316002)(186003)(6512007)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWE0dm53cmhycTNieUYwVXQ2dzZ3bkdWWFlabnJTTFRFWWNQTXRTcmp1blln?=
 =?utf-8?B?WGdpM21ST0tzVVh1M3VRRjR2M3hQVU12YzdNSE1IMkhDOHRPdVRTT3hjVmFH?=
 =?utf-8?B?ZUhvWVdRWnEvYmQ1d3NjWVU1T1dUR0o1MFVlamdpSUpMMHdhTWlRbithUWJn?=
 =?utf-8?B?aDc1ZGU3Vkl3d1dUOTZoSy9HNnIvUk93UXRZMHRQTGxwbHRRV0RNWlc5M1k5?=
 =?utf-8?B?Q1dZc3IwK25zaGtIVVNqOGhYNm5CWWFIOEptVnU4K3VmZTViRVd3eUhlSm5a?=
 =?utf-8?B?UzZ6eDFxWk50S1duZHdGZEtiTEZMVTlJUzV6dFBmOUpTQUdIWWlRWldtbGt2?=
 =?utf-8?B?SXZrVVNwT2NRUTJSMTNDb1p2N0VmQTJ6U2NadjZMcVJrSTV6STdKRERRUmJW?=
 =?utf-8?B?Tk91ZXR5akpmcy9SUmJBMnh0RmsxM0llVW1WdmpUNzFScjlhdGc0QmlBTHNN?=
 =?utf-8?B?KzMzaWNqZXE5dFI0TUxHQnlGbFR6M3FOb0tKclpkQkd6MTNPYzJQbmtDT0U3?=
 =?utf-8?B?a1BmZ0hWc3N6Zm9NK0tZV3VaVVA5R2UzZU5hajF4Njc1ODJadWhYcXhGdlB1?=
 =?utf-8?B?ZFVtSDNDSzE5NXQ2czl6K1NISThrYWxkc29IWnExVjY1NTRnOWlrcWU4emNF?=
 =?utf-8?B?eCtIUFlRempmMXJDT0wydHJ1dzd1UmhjR0FZay9FM1dxV01YeFNIa2JIUzV2?=
 =?utf-8?B?R1EyNFpRVktxSjc2WWkvaWtvdSt2S0ozQnBGa0FXL2FIZXE4Y3lFWVpnL3J6?=
 =?utf-8?B?SXlpQWRudFIwSnR5Y3puWFM2aWJNYXFOcGc5ZnVLYlBOLzd0SC81L0s2aTFu?=
 =?utf-8?B?bXBFZVNWUnpDdDh4bTh1RW9tK3ZxQkZqVWFIdFdpTW0vcCt0dXU5MFZvTXRl?=
 =?utf-8?B?NHY4azVRajR2dk15QURsZVRvYW9EVEs3bmhxWWpnRzR5QWJVcXZrU2c1anFO?=
 =?utf-8?B?RngvZmxaR1NpOWVWTi9XVTJ0NVBUYkpUYTUxMmMxd0IxbGppZlFPT0dZVnlS?=
 =?utf-8?B?WGdsNXVFSFdLcW1FWFAwRk9uU2JWRjZTK1FFT2JMeGFqalhsVk94RHNyaEpR?=
 =?utf-8?B?Rko0OE5LRHZPZXk4RlQycEN3U1JlSDY1QWRSRjhqZnFHTVdCeklPL1ZqR2o2?=
 =?utf-8?B?V3dhdzlxM1ZMbUVYTWdKNkZaUnFWUldZQlR1RVFXQ3hZaytGZnNuZlllTE00?=
 =?utf-8?B?Qlp3and0d2NtbE1ZUnJuZUg4amNzdUpjbmpUUzdyWG9YaXpLellVUUo5SGVp?=
 =?utf-8?B?bnZMWXpNUi90RTNwSlMvUlRJZmtERWZYOFJRdjhFSDBOaHJNZ2NOVHJKcGVv?=
 =?utf-8?B?MnQ3THpFM2RUYkRKcW0rdktFK01yZHA0Y3YxRkZtRE9kSlJpblo2S3JyL3RM?=
 =?utf-8?B?dEVSL2dDdmZ1eU9ERG5oeWhueWVLckNNNDFnaWpkK3g4bE5JTTF2a1ZBVC9S?=
 =?utf-8?B?RzByYnFzTXlxTjFUcWk5MVIrRkNOZ1NzUDU2RGNYY2RhSk51emwrMmNhazJi?=
 =?utf-8?B?QXJaOXpiRW5jTUl3cmIwSWlQM08zSTk0dVYvVElTeWhELzByTnZBNFJsb1h1?=
 =?utf-8?B?MmRwMDVYRFhpK01CM2RXNm0zWHkxZCtyTFFrUWxRWkdWME45LzZ0L0Q5Qlkr?=
 =?utf-8?B?K0VsSHhURFBTQ1lYcy9VNW1oMXRSRDFodWs2eFpYTWN2NGZCcDdDUTZPRUhI?=
 =?utf-8?B?ZWR5eHlpeWo0SmhEK1JwbWRTV0oxRm9OVThmLzNZSGlyYldWeVhyU2RIL1dH?=
 =?utf-8?B?V0JOTWlLRk9XMThFbllXYWl6R05vcEJvYWpvRWp1VXdHcHRkdzREUTFzYm5x?=
 =?utf-8?B?NjJ1UWE5OVo1Y0lDblp4VjhWR0FtRlFlQzdxVE5JTWk5b3hIZW9lMHdVbFIw?=
 =?utf-8?B?VHBqZlRINnpkc2h0YnJhcjQzWkxXQ2thQmw5bkdYb3F5SktycElVRmsyRzEx?=
 =?utf-8?B?S3dNM3JMVUd6RU1TV0EzUSsvOG9nbzlBQTNxQ3llSmZxaUZXZmFKSVNwYnpj?=
 =?utf-8?B?WXRWTWV2ekRnS3kxVXVBWi9mSXBNSGFZaksvSkVwM1FkUThLREVrQS93MXZG?=
 =?utf-8?B?K01mMjRkN1kvMzA1TVZCbytTd1UydFlVbjVuYXZUU2ZhWWxsWVpyR01vU2VG?=
 =?utf-8?Q?hUlq8qJxWzbxmsnkgJIe4CF5p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df01e27-fb56-4b52-0054-08daa097a511
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:50:39.8862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wmfbyG2aEqiSKspa5rsG0EMpmMyKVHmL6PmoKTUKeoGQ5SfazQ7f7quzOLwcMOCrAmvIJx1FsofAC8Gw3QfNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 4:34 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 7:50 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/27/2022 4:00 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/27/2022 7:17 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/27/2022 3:29 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 6:23 PM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>>>>>>>> This patch adds new functions which will allow a user to
>>>>>>>>>>>> change the GPU power profile based a GPU workload hint
>>>>>>>>>>>> flag.
>>>>>>>>>>>>
>>>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>>>>>>>> +++++++++++++++++++
>>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 
>>>>>>>>>>>> +++++++++++
>>>>>>>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>>>>>>>   create mode 100644 
>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>>>   create mode 100644 
>>>>>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o 
>>>>>>>>>>>> amdgpu_ib.o amdgpu_pll.o \
>>>>>>>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>>>>>> amdgpu_sync.o \
>>>>>>>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o 
>>>>>>>>>>>> amdgpu_vram_mgr.o amdgpu_virt.o \
>>>>>>>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>>>>>>>> diff --git 
>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>> index 000000000000..a11cf29bc388
>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>>> @@ -0,0 +1,97 @@
>>>>>>>>>>>> +/*
>>>>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * Permission is hereby granted, free of charge, to any 
>>>>>>>>>>>> person obtaining a
>>>>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>>>>> (the "Software"),
>>>>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>>>>> without limitation
>>>>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>>>>> distribute, sublicense,
>>>>>>>>>>>> + * and/or sell copies of the Software, and to permit 
>>>>>>>>>>>> persons to whom the
>>>>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>>>>> conditions:
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * The above copyright notice and this permission notice 
>>>>>>>>>>>> shall be included in
>>>>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF 
>>>>>>>>>>>> ANY KIND, EXPRESS OR
>>>>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>>>>> MERCHANTABILITY,
>>>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  
>>>>>>>>>>>> IN NO EVENT SHALL
>>>>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
>>>>>>>>>>>> OR OTHERWISE,
>>>>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
>>>>>>>>>>>> OR THE USE OR
>>>>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + */
>>>>>>>>>>>> +#include <drm/drm.h>
>>>>>>>>>>>> +#include "kgd_pp_interface.h"
>>>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>>> +
>>>>>>>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>>>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    switch (hint) {
>>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>>>>>>>> +    default:
>>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>>> +                uint32_t hint)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>>>>> +        return 0;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>>>>
>>>>>>>>>>> If it's all about pm subsystem variable accesses, this API 
>>>>>>>>>>> should rather be inside amd/pm subsystem. No need to expose 
>>>>>>>>>>> the variable outside pm subsytem. Also currently all 
>>>>>>>>>>> amdgpu_dpm* calls are protected under one mutex. Then this 
>>>>>>>>>>> extra lock won't be needed.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is tricky, this is not all about PM subsystem. Note that 
>>>>>>>>>> the job management and scheduling is handled into amdgpu_ctx, 
>>>>>>>>>> so the workload hint is set in context_management API. The API 
>>>>>>>>>> is consumed when the job is actually run from amdgpu_run() 
>>>>>>>>>> layer. So its a joint interface between context and PM.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If you take out amdgpu_workload_to_power_profile() line, 
>>>>>>>>> everything else looks to touch only pm variables/functions. 
>>>>>>>>
>>>>>>>> That's not a line, that function converts a AMGPU_CTX hint to 
>>>>>>>> PPM profile. And going by that logic, this whole code was kept 
>>>>>>>> in the amdgpu_ctx.c file as well, coz this code is consuming the 
>>>>>>>> PM API. So to avoid these conflicts and having a new file is a 
>>>>>>>> better idea.
>>>>>>>>
>>>>>>>> You could still keep a
>>>>>>>>> wrapper though. Also dpm_* functions are protected, so the 
>>>>>>>>> extra mutex can be avoided as well.
>>>>>>>>>
>>>>>>>> The lock also protects pm.workload_mode writes.
>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>>>>> +        goto unlock;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>>>>>>>> +    if (!ret)
>>>>>>>>>>>> +        adev->pm.workload_mode = hint;
>>>>>>>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>>>>>>>
>>>>>>>>>>> Why is this reference kept? The swtiching happens inside a 
>>>>>>>>>>> lock and there is already a check not to switch if the hint 
>>>>>>>>>>> matches with current workload.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This reference is kept so that we would not reset the PM mode 
>>>>>>>>>> to DEFAULT when some other context has switched the PP mode. 
>>>>>>>>>> If you see the 4th patch, the PM mode will be changed when the 
>>>>>>>>>> job in that context is run, and a pm_reset function will be 
>>>>>>>>>> scheduled when the job is done. But in between if another job 
>>>>>>>>>> from another context has changed the PM mode, the refrence 
>>>>>>>>>> count will prevent us from resetting the PM mode.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This helps only if multiple jobs request the same mode. If they 
>>>>>>>>> request different modes, then this is not helping much.
>>>>>>>>
>>>>>>>> No that's certainly not the case. It's a counter, whose aim is 
>>>>>>>> to allow a PP reset only when the counter is 0. Do note that the 
>>>>>>>> reset() happens only in the job_free_cb(), which gets schedule 
>>>>>>>> later. If this counter is not zero, which means another work has 
>>>>>>>> changed the profile in between, and we should not reset it.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> It could be useful to profile some apps assuming it has 
>>>>>>>>> exclusive access.
>>>>>>>>>
>>>>>>>>> However, in general, the API is not reliable from a user point 
>>>>>>>>> as the mode requested can be overridden by some other job. Then 
>>>>>>>>> a better thing to do is to document that and avoid the extra 
>>>>>>>>> stuff around it.
>>>>>>>>>
>>>>>>>> As I mentioned before, like any PM feature, the benefits can be 
>>>>>>>> seen only while running consistant workloads for long time. I an 
>>>>>>>> still add a doc note in the UAPI page.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> a) What is the goal of the API? Is it guaranteeing the job to run 
>>>>>>> under a workprofile mode or something else?
>>>>>>
>>>>>> No, it does not guarentee anything. If you see the cover letter, 
>>>>>> it just provides an interface to an app to submit workload under a 
>>>>>> power profile which can be more suitable for its workload type. As 
>>>>>> I mentioned, it could be very useful for many scenarios like 
>>>>>> fullscreen 3D / fullscreen MM scenarios. It could also allow a 
>>>>>> system-gfx-manager to shift load balance towards one type of 
>>>>>> workload. There are many applications, once the UAPI is in place.
>>>>>>
>>>>>>>
>>>>>>> b) If it's to guarantee work profile mode, does it really 
>>>>>>> guarantee that - the answer is NO when some other job is running. 
>>>>>>> It may or may not work is the answer.
>>>>>>>
>>>>>>> c) What is the difference between one job resetting the profile 
>>>>>>> mode to NONE vs another job change the mode to say VIDEO when the 
>>>>>>> original request is for COMPUTE? While that is the case, what is 
>>>>>>> the use of any sort of 'pseudo-protection' other than running 
>>>>>>> some code to do extra lock/unlock stuff.
>>>>>>>
>>>>>>
>>>>>> Your understanding of protection is wrong here. There is 
>>>>>> intentionally no protection for a job changing another job's set 
>>>>>> workload profile, coz in that was we will end up 
>>>>>> seriazling/bottlenecking workload submission until PM profile is 
>>>>>> ready to be changed, which takes away benefit of having multiple 
>>>>>> queues of parallel submission.
>>>>>>
>>>>>> The protection provided by the ref counter is to avoid the 
>>>>>> clearing of the profile (to NONE), while another workload is in 
>>>>>> execution. The difference between NONE and VIDEO is still that 
>>>>>> NONE is the default profile without any fine tuning, and VIDEO is 
>>>>>> still fine tuned for VIDEO type of workloads.
>>>>>>
>>>>>
>>>>> Protection 1 is - mutex_lock(&adev->pm.smu_workload_lock);
>>>>>
>>>>> The line that follows is amdgpu_dpm_switch_power_profile() - this 
>>>>> one will allow only single client use- two jobs won't be able to 
>>>>> switch at the same time. All *dpm* APIs are protected like that.
>>>>>
>>>>
>>>> this also protects the pm.workload_mode variable which is being set 
>>>> after the amdgpu_dpm_switch_power_profile call is successful here:
>>>> adev->pm.workload_mode = hint;
>>>>
>>>>> Protection 2 is - ref counter.
>>>>>
>>>>> It helps only in this kind of scenario when two jobs requested the 
>>>>> same mode successively -
>>>>>      Job 1 requested compute
>>>>>      Job 2 requested compute
>>>>>      Job 1 ends (doesnt't reset)
>>>>>
>>>>> Scenario - 2
>>>>>      Job 1 requested compute
>>>>>      Job 2 requested compute
>>>>>      Job 3 requested 3D
>>>>>      Job 1 ends (doesnt't reset, it continues in 3D)
>>>>>
>>>>> In this mixed scenario case, I would say NONE is much more 
>>>>> optimized as it's under FW control. Actually, it does much more 
>>>>> fine tuning because of its background data collection.
>>>>>
>>>>
>>>>
>>>> It helps in mixed scenarios as well, consider this scenario:
>>>> Job 1 requests: 3D
>>>> Job 2 requests: Media
>>>
>>> Ok, let's take this as the example.
>>>
>>> Protection case :
>>>
>>> Job 1 requests: 3D => adev->pm.workload_mode = 3D; and protected by 
>>> mutex_lock(&adev->pm.smu_workload_lock)
>>>
>>> Jobe 2 requests  => adev->pm.workload_mode = Media;
>>>
>>> What is the use of this variable then? Two jobs can come at different 
>>> times and change it independently? Any use in keeping this?
>>
>>> Some other job came in and changed to some other value. So, what is 
>>> the use of this lock finally?
>>>
>> ?? The locks are not to save the variable from being changed, but to 
>> save the variable being changed out of context. If two threads try to 
>> change it at the same time, one of them will have to wait until the 
>> other critical section is done execution.
>>
>> Do note that this variable is changed only when 
>> amdgpu_dpm_switch_power_profile() call is successful. Going by the 
>> same logic, what is the use of having these pm locks inside the 
>> function dpm_switch_power_profile(), as Job 1 changed the power 
>> profile to 3D, and Job 2 changed it to media :) ?
> 
> That lock is protecting the swsmu internal states from concurrent access 
> and not profile mode. 
That's the intention of the lock, to prevent the state. It is not 
supposed to prevent a profile change. So its doing its job.

> Here I don't see the use of this variable.

This variable is being used to block duplicate calls to this function, 
if we are already running in the same mode. Cosidering the number of 
jobs we submit, its absolutely worth. We have been talking about CPU 
cycles since some time, and its doing the same very well.

>   Using those locks does not prevent
>> chaning the PM profile, it makes sure that it happens in a serialized 
>> way.
>>
>>> Use case:
>>>
>>> Job 1 requests: 3D
>>> Job 2 requests: Media
>>>
>>> Job 1 now runs under Media. What is achieved considering the intent 
>>> of the API and extra CPU cycles run to protect nothing?
>>>
>>
>> This is how it is intended to work, I have explained this multiple 
>> times before that we do not want to block the change in PP from two 
>> different jobs. The lock is to protect concurrancy sequence, not 
>> change in mode:
>>
>> without that lock in the worst case scenario:
>>
>> Thread: 1
>> Job 1 requests: 3D
>> PM mode changed to: 3D
>> just before writing (adev->pm.workload_mode = 3d) this thread 
>> schedules out
>>
>> Thread:2
>> Job 2 requests: Media
>> PM mode changed to: Media
>> adev->pm.workload_mode = media
>>
>> Thread 1 schedules in:
>> adev->pm.workload_mode = 3d but PM mode media.
>>
>> State machine broken here. So the lock is to provide sequential 
>> execution of the code.
>>
>>
>> If your suggestion is we should not let the mode get changed until one 
>> job is done execution, that's a different discussion and certainly not 
>> being reflected from what you wrote above.
> 
> My suggestion is not to waste extra CPU cycles/memory when the API 
> doesn't give any guarantee about its intended purpose (which is to keep 
> the profile mode as requested by a job). Let it be stateless and 
> document the usage.
> 

 From the comment above, the state helps to block duplicate calls, so 
its saving CPU cycles rather than wasting it. Now, the guarentee of the 
execution is something which we can discuss, I am open to suggestion on 
a policy, which can do better.

- Shashank

> Thanks,
> Lijo
> 
>>
>> - Shashank
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Job 1 finishes, but job 2 is ongoing
>>>> Job 1 calls reset(), but checks the counter is non-zero and doesn't 
>>>> reset
>>>>
>>>> So the media workload continues in Media mode, not None.
>>>>
>>>> - Shashank
>>>>
>>>>>> In the end, *again* the actual benefit comes when consistant 
>>>>>> workload is submitted for a long time, like fullscreen 3D game 
>>>>>> playback, fullscreen Video movie playback, and so on.
>>>>>>
>>>>>
>>>>> "only under consistent", doesn't justify any software protection 
>>>>> logic. Again, if the workload is consistent most likely PMFW could 
>>>>> be managing it better.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> - Shashank
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Lijo
>>>>>>>>>
>>>>>>>>>> - Shashank
>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Lijo
>>>>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +unlock:
>>>>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>>>>> +    return ret;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>>> +                  uint32_t hint)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>>>>>>>> +        return 0;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    /* Do not reset GPU power profile if another reset is 
>>>>>>>>>>>> coming */
>>>>>>>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>>>>>>>> +        return 0;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>>>>>>>> +        goto unlock;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>>>>>>>> +    if (!ret)
>>>>>>>>>>>> +        adev->pm.workload_mode = 
>>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>>>>>>>> +
>>>>>>>>>>>> +unlock:
>>>>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>>>>> +    return ret;
>>>>>>>>>>>> +}
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct 
>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>>>>>>>> diff --git 
>>>>>>>>>>>> a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>> index 000000000000..6060fc53c3b0
>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>>> @@ -0,0 +1,54 @@
>>>>>>>>>>>> +/*
>>>>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * Permission is hereby granted, free of charge, to any 
>>>>>>>>>>>> person obtaining a
>>>>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>>>>> (the "Software"),
>>>>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>>>>> without limitation
>>>>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>>>>> distribute, sublicense,
>>>>>>>>>>>> + * and/or sell copies of the Software, and to permit 
>>>>>>>>>>>> persons to whom the
>>>>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>>>>> conditions:
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * The above copyright notice and this permission notice 
>>>>>>>>>>>> shall be included in
>>>>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF 
>>>>>>>>>>>> ANY KIND, EXPRESS OR
>>>>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>>>>> MERCHANTABILITY,
>>>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  
>>>>>>>>>>>> IN NO EVENT SHALL
>>>>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
>>>>>>>>>>>> OR OTHERWISE,
>>>>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
>>>>>>>>>>>> OR THE USE OR
>>>>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + */
>>>>>>>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>>>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>>>>>> +#include "amdgpu.h"
>>>>>>>>>>>> +
>>>>>>>>>>>> +/* Workload mode names */
>>>>>>>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>>>>>>>> +    "None",
>>>>>>>>>>>> +    "3D",
>>>>>>>>>>>> +    "Video",
>>>>>>>>>>>> +    "VR",
>>>>>>>>>>>> +    "Compute",
>>>>>>>>>>>> +    "Unknown",
>>>>>>>>>>>> +};
>>>>>>>>>>>> +
>>>>>>>>>>>> +static inline const
>>>>>>>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>>>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>>>>>>>> +        return 
>>>>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>>>>>>>> +
>>>>>>>>>>>> +    return 
>>>>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>>> +                uint32_t hint);
>>>>>>>>>>>> +
>>>>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>>> +                uint32_t hint);
>>>>>>>>>>>> +
>>>>>>>>>>>> +#endif
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>>>>>>>> +    /* SMU workload mode */
>>>>>>>>>>>> +    struct mutex smu_workload_lock;
>>>>>>>>>>>> +    uint32_t workload_mode;
>>>>>>>>>>>> +    atomic_t workload_switch_ref;
>>>>>>>>>>>> +
>>>>>>>>>>>>       struct config_table_setting config_table;
>>>>>>>>>>>>       /* runtime mode */
>>>>>>>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>>>>>>>
