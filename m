Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E523FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 15:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBF810EAB4;
	Thu, 27 Jan 2022 15:28:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D5110EAE8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 15:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+YtVAYHd1Sgh11hEAJy45luP3mM3TeMcbin+6iDNqcGZBIdaDWqAGk6SfjNTD4KHdHD3668DtvGFh/GfNHFlUCbaJQPBNm8Uc8I0DWP3EPMfRSqEQ9BvYkwKkwIzZbshMI9+0rLwaUM5uVwHGlwO7ysqP7tnWmByk2TIvwtAhtvDb25Boolp0G+GTpjM3VFjX9009thS/HUJTNXZ+rxUlSyD9IZKSnlAJmEQAhZrDh0ERroiyh7ryYCm9ZLHkm282XRiFOHoK0xB1cTNFpbepevvYO+aycji6iDgLrOP85wD6az/bt896lgARHcjwUqGvHY33o3ctuYqeblvLOm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVS0cMrZl8sTWe/FfdZ1rA+uO4LcgFw63I+FEOncVdo=;
 b=NUa0QO7r7ou8jjwMpcmtx6GmUVfFWGgFViM5yQ7wOJ5763vAfOS8yq5I+zW6nJkOw0h49amog4zhi6QDZ7SeBp3Voct1p9A5+nPedAreRNunzokPCjAjbph6QwUKpN+QJQ8RBfrUP2gpRo0AKltPY4gPBVSCbejcy49HJ0N8AWB89qOOfrH0sRpv8k5ltoSxouw2/R53d0JoQUHTmxQ21iz/w8+1A6Xqkun+4bP/fVrXwLiXxRFjSoj+958iDv5m123EiKoLXLf57I47/MsXk5BXsIGGmNtNhWFvrweJlxJ1gV9S4edrLsCPmG7Hu+/7O8uvWXU0obkrSIUExJEU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVS0cMrZl8sTWe/FfdZ1rA+uO4LcgFw63I+FEOncVdo=;
 b=SR1MW+hhBRymrhclLVBPbA2KPsDeG1BwY1Ed19NRCI769TS6hf3PeiXi9z+dhqO9NwRiUQXOFmDFKDrAyvQwhQ1+aCqvNbGxvq76SlLbEW9Xg5H64Y6T9hsE3Sk4v90x7FNvjmX/OswcgZ+VInvg3oEwJ7Co4+H5Ov++0SADF2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 15:28:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 15:28:43 +0000
Message-ID: <1f6ae3fe-5463-cf80-063a-2c8a500b9b2a@amd.com>
Date: Thu, 27 Jan 2022 10:28:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Content-Language: en-US
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
 <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
 <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
 <c7a7d79c-c59e-51ed-07fc-22d9b57c1271@amd.com>
 <DM4PR12MB5294D2C47F12FC897406884295219@DM4PR12MB5294.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM4PR12MB5294D2C47F12FC897406884295219@DM4PR12MB5294.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb9e58b-9b1c-49bc-96c9-08d9e1a9b404
X-MS-TrafficTypeDiagnostic: BY5PR12MB4885:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4885EAFE53CFFED2F2E5121392219@BY5PR12MB4885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDNnfqfVhhmMLL2pMQVxD6kggqUiZnO4zALyrNz3DH8K/8Mtl4OvJUah1tZhPLoMid2cRErJqOTMQ6Vs+qBQLMqOyuI68EcGGpGWt4RhmvCpGk+00E1KTCWNl5aDpMhwJHIiLLtVfShWyye6QuSdHzBL75nMljS04aT6dlIhJKtOb7/VyAhO8+zKcq6MeLcy8m3cmLax7+Q23O45XGaugU0AaPQXU+7/svNS81CKQEGACnl175MiD1mXCFeXOD9Qnc13uZ/dA1ZHNvf/ol+EM225p06cHJLDCPdXhojeQOR/eiip3AeyQAv0CKy9FA/voDtDMg62PfR0fyRVEY5hBG/zDa1GHObKRXx5oMYLgIHUFk5aUk2FCT64EAfG2VOrzXagsWzjH/5E83sLgX99daf1lFg+43DvbW5wVn6GOO1UlIifpxfGWA92cuYEHk62qjBtd7ROmNQTmJr8zxT26LQzQjG/UGflqjGVYuEBTI63E3f5walQ0hrgKb+GZUkVkR4kcppJrRium0fXMpF3CwhzKoPpJvhBEbA1DyYoAMKfzb+YT1472T5IW64BhOb91zYL2KLK/z7RUKxymfa8gan5KP5jYsuHqwpRFtexRNzIgRcaF4VMlWOhCy6HCWL7iCq9D/dLQCPG3XJPVJ659J2TtXjuYWt6HVoZcp7CLODYDI34YUpMD5nUBTEJ6dr9vq8gFhKvKYG7jBJ9BCMIAgZ5zb8owDVl7r0miwibWeFbWCglWnlcNrI+is+HOHSq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(316002)(186003)(66946007)(6506007)(26005)(6512007)(2616005)(54906003)(83380400001)(44832011)(31686004)(5660300002)(4326008)(6486002)(2906002)(8936002)(508600001)(8676002)(38100700002)(31696002)(86362001)(66476007)(15650500001)(66556008)(36756003)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkEyMGJ6U0k5bVBNa1A5ZmhBOTc5ZUl1eFBFTWhMSUJpaGFKMmU1LzFYM252?=
 =?utf-8?B?amZYai81Snh3TVVXK1Fub2p2bklwMTJReWRGTldKdGRybnNiK0ZZZHQ1UDFM?=
 =?utf-8?B?S2JjL1pIb2piRHYxMm5QMW9hWGJiYzN3Mlh1bFNIOTJINElDRDgzUXRkdkhm?=
 =?utf-8?B?dzZZc3JXMjdsU0d0cHR5OHpoeVAxRUVPbHRkNHRRRXhJcm1velpGK1k5dnFH?=
 =?utf-8?B?bjhlMnF6dlNLTkxsNzEwTmFXV2ljdWg2cEtoME5EQ2htNHVkUTVuOWF3R2tT?=
 =?utf-8?B?cThscUFQZGxrTGI1RGJiWWxQR2ZKd0VYTzNvcS9XTlc2RFRRL2JyeWUxbFBM?=
 =?utf-8?B?UGpzVXVXMTUwU0YxK0NzV1FUSHFwUnRpU2NUVjR3Um9aWmd2aU9JYmN6NnFL?=
 =?utf-8?B?UzlwNnhOdFFpVnFybW5sMUkxeFdOcnBBYWZXVVNpQmswaHFQc2NoMGlxSmNh?=
 =?utf-8?B?akpsLzJUNksrNnlwSHI1K1pSTFZEOUJsWDkrb2RRYXA3UnpJR2RmOHJjbEsv?=
 =?utf-8?B?R3BWeEtCUXYrVW9WZm5PT3lkRnBpYnZJcEl2ck9lWDNqT2tsUVB2YVdSbzR2?=
 =?utf-8?B?ZDJaQm5mVys3d25WY1NiaERMWWJCNUIwbVBRWWdGZlRKUU4wZHlJN0JBb05Y?=
 =?utf-8?B?SnJlMVQ5UW9Iazl6TVk1N1BIWlp3ZG5CajhLalZVSXl4a2NEeVM1L2pjQlpX?=
 =?utf-8?B?OE9oUWhsUFFUclpiYnFUaExKRWdib3ptd1RMcTNFWjNrbmpxMm54MjFRTllz?=
 =?utf-8?B?MThMVjE1eVh6TDdEd0ZjelBwUlBaUy84RjlXNnhwbTR2ZGlFMGlBWkNrSnd2?=
 =?utf-8?B?eDBsRklUcW9YOUxVQTJXdDdhWThtMHpicUk1TDRId0JaalhSdXlNZWJxUUxr?=
 =?utf-8?B?RE5lY0NFMDRzUnhxZS9PK3Z3YXJBVldmUWRrNGlMaUdUV2hhcDBzMysxS3Bv?=
 =?utf-8?B?MkRibWZWVHY2N1NrMzgzampvWXNDRm1YVFBpK1Q3WUlpM2lMQVJXN3BWUUow?=
 =?utf-8?B?MEJjd0lTQUphSXh5dlhtbllML0xJUzZlLzBmd0lSQmFUeStQd3J4K3l3THpX?=
 =?utf-8?B?TDA4dnM0ZFVnRytBdStPNVF3SkVVN1IzTndZKzNieDFQRElOSDBLUXJCbHBl?=
 =?utf-8?B?a05QdkZhUGhLUGs3dEZnYW93bDlURjlHZXF6UklQVDZRdWp3K0k3RWQwOWhX?=
 =?utf-8?B?Zmp5NDJ1L3llSjcvOWNRc0RwOTJmOHpaUTFWTnhmWGNnY0YyWm84QXJibDBR?=
 =?utf-8?B?ZkNFRjFyRkRwc01hbUlEOVZ4U1VXYmY4TEsybU1CQjF0bUkwMGwxUkNLalJj?=
 =?utf-8?B?UVhjWUZrbkc4bm1GUUFIQVgwNmJZWGpQOGZXQ3k1Y1Y3dXpQTFYzUzhIVnY2?=
 =?utf-8?B?RzE0cGw2dXhRdW84ZWVIcEluR3lDSmxuRUJDUDJmb1JKYmVZQnZpSERRNS9k?=
 =?utf-8?B?aERSQUlMN1VnbTJ0WUR3ME4xcTBRY1BwU0dxajJXb0JuZ1hhVmR3d2VSQ2pZ?=
 =?utf-8?B?TjNKNkRkWFA2N1Zvbnk2N2oxKzNVNDJydXoxN24rTDVmWmNiNy82QTd4djd3?=
 =?utf-8?B?ZEpsbjJpTkxKUWNWbE90SmR1K2dYWWhvQWgzZ3dpS05hS3NWWEtFeTk5THVL?=
 =?utf-8?B?N1Y1d0N2cUh3YmFxZkdzUzl4SXUvZ0pTMVlJeGRQSFNRYlU4S3pqRUl1ci9W?=
 =?utf-8?B?UExpVnFsWmZWVitoRU1WN1B3NFVkRGFORnZGVXhtNVlsOFEyTndRcnAxWnY0?=
 =?utf-8?B?dEkzMWNmQ24zaTBSRnFSVEVFWjlLWjVlUVdIcWVHVGpteTlYeUY4Ymk3d0hq?=
 =?utf-8?B?UlNJdUk5b21DRlRhUHhuRzNMWTk2a2Z2M2xlOGNJMlJyT0tJSVpMWS9sQndC?=
 =?utf-8?B?M2lieUtVM0xsZ2cwbVJYbmR4MWRvTEM4UVNvTHowSDE5SmJubE05SThaazFF?=
 =?utf-8?B?L1Jsd3EzTTR0Y2F2VEdjcXpJaTZaUHl2R1N5NnowNEVvZjBHVVZFZ0JGcUo5?=
 =?utf-8?B?QWpQY1NCTW15dmVLU1dEU1REMllQU0tSL2hwRGdZMWZBWm1CdWRzN2pBSG5Y?=
 =?utf-8?B?VVVkQnVwck9rc3FrNlVsdlN4NkFlaklRTW5VY0kwbTZmT24vQlBlaTBjRWsv?=
 =?utf-8?B?Y0dWeWpJcmtGN2JaRkhJVTM5UFA3WFM0eXRSazAyajJKV0d2c2h0RnhEM0xU?=
 =?utf-8?Q?IXzJrbwyw+zYp2lxYSQOs3g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb9e58b-9b1c-49bc-96c9-08d9e1a9b404
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:28:43.7120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhF3m/z3MPYKbFL+k7eK7j6F5s0YZF40+3m4Bt7zBdPhqs+yPCS23r3GDlzDopRgCdMd5r53b2tXZHYh5JUK/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The hang you're seeing is the result of a command submission of an 
UNMAP_QUEUES and QUERY_STATUS command to the HIQ. This is done using a 
doorbell. KFD writes commands to the HIQ and rings a doorbell to wake up 
the HWS (see kq_submit_packet in kfd_kernel_queue.c). Why does this 
doorbell not trigger gfxoff exit during rmmod?


Regards,
   Felix



Am 2022-01-26 um 22:38 schrieb Yin, Tianci (Rico):
>
> [AMD Official Use Only]
>
>
> The rmmod ops has prerequisite multi-user target and blacklist amdgpu,
> which is IGT requirement so that IGT can make itself DRM master to 
> test KMS.
> igt-gpu-tools/build/tests/amdgpu/amd_module_load --run-subtest reload
>
> From my understanding, the KFD process belongs to the regular way of 
> gfxoff exit, which doorbell writing triggers gfxoff exit. For example, 
> KFD maps HCQ thru cmd on HIQ or KIQ ring, or UMD commits jobs on HCQ, 
> these both trigger doorbell writing(pls refer to 
> gfx_v10_0_ring_set_wptr_compute()).
>
> As to the IGT reload test, the dequeue request is not thru a cmd on a 
> ring, it directly writes CP registers, so GFX core remains in gfxoff.
>
> Thanks,
> Rico
>
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Wednesday, January 26, 2022 23:08
> *To:* Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Yang(Kevin) 
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun 
> <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> My question is, why is this problem only seen during module unload? Why
> aren't we seeing HWS hangs due to GFX_OFF all the time in normal
> operations? For example when the GPU is idle and a new KFD process is
> started, creating a new runlist. Are we just getting lucky because the
> process first has to allocate some memory, which maybe makes some HW
> access (flushing TLBs etc.) that wakes up the GPU?
>
>
> Regards,
>    Felix
>
>
>
> Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):
> >
> > [AMD Official Use Only]
> >
> >
> > Thanks Kevin and Felix!
> >
> > In gfxoff state, the dequeue request(by cp register writing) can't
> > make gfxoff exit, actually the cp is powered off and the cp register
> > writing is invalid, doorbell registers writing(regluar way) or
> > directly request smu to disable gfx powergate(by invoking
> > amdgpu_gfx_off_ctrl) can trigger gfxoff exit.
> >
> > I have also tryed
> > 
> amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,false),
> > but it has no effect.
> >
> > [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed
> > [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff
> > [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff
> > [10386.162297] amdgpu: mmCP_STAT : 0xffffffff
> > [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff
> > [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff
> > [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff
> > [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff
> >
> > Thanks again!
> > Rico
> > ------------------------------------------------------------------------
> > *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> > *Sent:* Tuesday, January 25, 2022 23:31
> > *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yin, Tianci (Rico)
> > <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> > <amd-gfx@lists.freedesktop.org>
> > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun
> > <Guchun.Chen@amd.com>
> > *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> > I have no objection to the change. It restores the sequence that was
> > used before e9669fb78262. But I don't understand why GFX_OFF is causing
> > a preemption error during module unload, but not when KFD is in normal
> > use. Maybe it's because of the compute power profile that's normally set
> > by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.
> >
> >
> > Either way, the patch is
> >
> > Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >
> >
> >
> > Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > > the issue is introduced in following patch, so add following
> > > information is better.
> > > /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> > > /
> > > /
> > > Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> > > /
> > > /
> > > Best Regards,
> > > Kevin
> > >
> > > 
> ------------------------------------------------------------------------
> > > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > Tianci Yin <tianci.yin@amd.com>
> > > *Sent:* Tuesday, January 25, 2022 6:03 PM
> > > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci
> > > (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > > *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> > > From: "Tianci.Yin" <tianci.yin@amd.com>
> > >
> > > [why]
> > > In rmmod procedure, kfd sends cp a dequeue request, but the
> > > request does not get response, then an error message "cp
> > > queue pipe 4 queue 0 preemption failed" printed.
> > >
> > > [how]
> > > Performing kfd suspending after disabling gfxoff can fix it.
> > >
> > > Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> > > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index b75d67f644e5..77e9837ba342 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct
> > > amdgpu_device *adev)
> > >                  }
> > >          }
> > >
> > > -       amdgpu_amdkfd_suspend(adev, false);
> > > -
> > >          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > >          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > >
> > > +       amdgpu_amdkfd_suspend(adev, false);
> > > +
> > >          /* Workaroud for ASICs need to disable SMC first */
> > >          amdgpu_device_smu_fini_early(adev);
> > >
> > > --
> > > 2.25.1
> > >
