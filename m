Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C68CD611E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666BA10E2C4;
	Mon,  9 Oct 2023 18:44:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C8210E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ply1MzET5p9mwnyAjadPXGkelDvJqJPayDLzW3abSDOZSVwG9NsRXjUE3lb0ouzFo0nhPPLaDTOfepmk30L3hJwjo0cEuRqt3FKF0mdXOgrN0yxKnKvcTvD91oNutL+hFWpF8lrn6Dwnu7lKLqTEoxT6+hknPnUt0Vhdr6wOvzZJk53JOdzMi7ACVOUUfMIyRGApgOg00+6FTTNOPKubZiVAHq5s/3uMsGoFTwW2L3S0GTq/Sou7wxAmZ78ScJo7rI1sMM/QbMJCMuC5MPhVgMCrOmebU6yyZSAAecJ04zH4YFrXKSfkZ/ouzjl3HWkyeueDxK2I3tvOOfaUg0QnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCF82RPmWBPwVeB4gnUsID1NcvveiQzzev52rEC+418=;
 b=fjeF82+zXjISIceWKeNpBvw36FBncNqMKSxIENsiZFVueixNMaVopKgXgMb180VdGWNcy+lrWXFO98legJ7vabD4GjTIZQ/fRSWSXkBYwiWH0dp8fVI/hsxpNQBBDDpRmjjeIoB0QyDsfoLkMbs+7ndh8RYPZ4HcvZdoNtYR17PhH9m+tfamPHTBRZppwh2wa82kKnOZHX53FPoUlZctzQvhlpI/vLJKJlDCpUz+EuV8YOpCB0aZQRUpdtVK7C0uowU1tDBx/MhvrP3L5MwH7b0NSy3EcTPnWyVem2dAID3zGwKe3mfYiWyqVdyad7ZEOwitz57PgrDbfEwvxCQTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCF82RPmWBPwVeB4gnUsID1NcvveiQzzev52rEC+418=;
 b=jewBBJ+d8ZSzocsmq+EyJ3Rc6FjGUtowKRjhH9Jp32/ff2cFG8MRdya9JhUz46fXzqjnSuWGaVhkvNJomKMEzOwckCbt+kcj3kKY5YupFJkP53D+Kun6FGAls84GJrcrV0DFDOk3S7ehTLy1Ytmwiak3IG7k7sPiGrezJx1z9rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 18:43:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 18:43:55 +0000
Message-ID: <f11dd06c-9504-4a9b-8bf1-95bfa62bed4c@amd.com>
Date: Mon, 9 Oct 2023 13:43:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] drm/amd: Capture errors in
 amdgpu_switcheroo_set_state()
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
 <20231009155426.96232-5-mario.limonciello@amd.com>
 <CADnq5_M6yqe_2UkrTbDO9AVKOHxwN6rzJ_NqR3bPnexUxGnytw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_M6yqe_2UkrTbDO9AVKOHxwN6rzJ_NqR3bPnexUxGnytw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:5:bc::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf87275-aa90-4824-79ea-08dbc8f7b0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfpVd6QzLDgEqDbiMW1BAq4KVFTYUw48W1cURel+hjgKgQ9SGKgjNjMK8yiTlMFXbHeN6wDIczbsaJWKm53SGleiNpTF5Oij0/8g0LP/QbnjA0VcU9p3JHiby0F6mbWhtIHGl3iZeEJP1fYY2A0g2gsj3lnbp2vyp6BY3XOKQTx0xF8wf29kVHNbPMfu7S4msxNqdUPwhp49823wymSHm56Jtf3xZRQORYYPBOPJVi80ZAGpDtuwW7OD0ni8xT1PB8b/TLiOB833+ozW5go4o1+OPWYI9fBsv/hHBTDIa5Eqw06dfdbiW2An3XIaFo0JHP/HBqun2CUlGl0rGn2WAVXNk3Sb//qv41hySCLkjgVSaipbu9g50pPQmKPoIRytVoPcQHyfK9zp0PB8pgPxSyqpO4Hjr1RydxtIzzlMWtS12lCJsuhKU/XMAjAQhtPWCLHrkoHf0YnS3u6XXQvObrPkUv1K3rILKYSDQkSHM5vgFKOhdFOcboxtETEBucqEj2IddDMC03ZKZwyhBCA/7cwXbktahdZiG5QbNEOI8cL1o3tPqdMrNRGtSjg2zSetgWWy8T0grhYmOUTqTyDulLOJfdwGaP1fZUV4s3rjz4pMPArHPGLWVxhoLGAfBSmoSsgpn6HaT0EnicskAH/NDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31696002)(38100700002)(86362001)(36756003)(31686004)(2906002)(6512007)(478600001)(6486002)(41300700001)(8936002)(53546011)(5660300002)(4326008)(44832011)(6506007)(8676002)(83380400001)(2616005)(66476007)(66556008)(66946007)(6916009)(26005)(316002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c28vSHdnSi9ydVVzUXJuZUFHUXNJY2dpbnYwRTRERWtWdDVYOFRNbG9DRHhq?=
 =?utf-8?B?SnVYSWduS2ViTDR0MHFjUm1jNGtkc1ZaNGllK2lMSFhGTjVMTFFoWVN1d2Nq?=
 =?utf-8?B?TjMvSHZ6UlRzMkRKa3ZHZTYyZUhjTmY4OXMrSDk1Rlg0d1FrckdZNUh3VUpq?=
 =?utf-8?B?ckMxVGx4Q2ZCWWR6YTJpOXJJWXMxRU5obG1DTlFINTRQdGx5K0MydTQvTkRZ?=
 =?utf-8?B?b3l3eW91Qk1qVEVmN2Z5ZlltYm1uLzJyMldxV0pjZkFSSWtGd1JaN3YrSVJa?=
 =?utf-8?B?QWZVMDJla3lOclZuYlVYL3cxQ0ZrZVdUYy96Rldvb2poL2UwWGxJMkVUOWVo?=
 =?utf-8?B?TWlLZ0VqWDZLTEFnS3lBTGVjWEVJWk9ta0pwbG01c3hqZGFzNDkvRWpCRlFv?=
 =?utf-8?B?WkNaeHdzVWRiUFQwQ2NaNzBaZ2s4QmtkK1lTV0cybHBvMDNwYW9RcjBQbGNy?=
 =?utf-8?B?dUtCTEdCbENYNXBFRExiNnV3REJkSlc5aU44QkZuUFJoL3dNbWVZN2IyMHVP?=
 =?utf-8?B?K2tjdy8xcVB4N3pMM2JRdER4emZZTXB4N240eUt4QnVuT1diTlA5QlU1dDNY?=
 =?utf-8?B?ODQvbEx6ZHJ3cEFZY2djeTNHTG9VQUlHUEdoNlRhOW9POVpGOXZGdm55MWxm?=
 =?utf-8?B?UjBOOFpneDN0eXNhYTB6N3Z6MDhDVGRsQXV3b0VyN1RBN3M5eTVSYzBZcXRk?=
 =?utf-8?B?ak5XRUJLOUh1WXhuRWhDVkFOWWY4QXhaTitWa0JtUVNWd1MxNHNhUjdxQkxV?=
 =?utf-8?B?a0hSUlVVVTZENlhLUEUxZHduWnUvU2tKM2QwazQ3eGhrVDhycFVNamlWTlZF?=
 =?utf-8?B?dTRIQk1YK25nQjRRVExhTkVpMUlYZEgzenFZc3RndXFzQkFuektHTTBEaC90?=
 =?utf-8?B?L2Voa3RVQ2dSUjY1L3VqN1FjeHY2RmZ1QnNZY05zYWRTem9DMWdzVGFuQmI3?=
 =?utf-8?B?UkFIS0JiWGZxLzRzc1JXcEpXRGtnanArMWtwbUhQN3FEQnIrN3owZTFkcHlK?=
 =?utf-8?B?WW90MEFqQ1dRQitXSU5RODlmbGFEVERxSnB3QWlZck1Da3dYU0ttZ3VyY1hm?=
 =?utf-8?B?di8ybGQ3MzJCMTRMcVlsY2ErcmpEWGlaVzNrVGRBVnBaeHo3YnFYeDQ3cThK?=
 =?utf-8?B?ME5Pdk96WXZ3ZUhzYWlZT2pDbnNpWGNpNE5KQW9jOTJPN1ppeVVqa2hTQzNH?=
 =?utf-8?B?bjlpaGxGekM4S0xyUmhwTi9KdEhMVGE1KzBwLytjSGNPcFFOSDB2bFRQMjg2?=
 =?utf-8?B?a01vL3F0Tzh1bW1OM1JlZ2xGSXFFZFR3ZnhEMTNZYysxdnQ0NDhCZ3ZMQ2tl?=
 =?utf-8?B?NkFUOC80SGhFTXlHSWNzUEdRT3lsakZxVXc3WHFtaWtrTGNDNy9mQXMwLzFy?=
 =?utf-8?B?dXFiaHlPZkZlR3pBenA0SW5ZaGMzSFhBOVo1UzJuZExZNTRlS1Y0R3hPbjhn?=
 =?utf-8?B?VjRyVUhkK0F2RGhPWXJ2WGZUNWY2SWhPeVhpUFNjQ2xZR0Nqc3Juck5PcGVO?=
 =?utf-8?B?U0hSN2ZJd1VpcE5pZ2J2ckpkM2tVbkwyNG11Yll0MG9BT0x0OTI5UUhiWG40?=
 =?utf-8?B?cHZNL2RlSzVWR2o5N2FUR2h6QkpnOVVhN25ybnJwYlBKcGJvbzBYcmFibTRV?=
 =?utf-8?B?akp0V3ZXOG9Wc2c4aGJiS3NjZmR5WldIempGYk9KVjRhOTlQR1A1UjRsQzNk?=
 =?utf-8?B?OUxZQWlNRiswRlg5WTQ3U3BTWFFRRlVmR09hVGtLY1pDbEI5dmZYRW52VjlD?=
 =?utf-8?B?dUd1TUZsVE56WWNWYzJoREdpVGJYSUtVUmR4dS84a29ESHFqOGxuUGt6UmRU?=
 =?utf-8?B?VXdoUUFlUmo2TWFOd0dIQ21ad09NVGsxMFR1V0tiM0k4VTNyeXJacmI1aG5S?=
 =?utf-8?B?cXh6Z3hrb1RtK1NVTHhieTNvUVh6T0tKZHZzazlEMC9ta0RSaWhtVVhjZm5X?=
 =?utf-8?B?anozQk5qcERPa2ZCN2ZxVzV3L0Z6azg3Z1NpcmdLN0ZRdFFETHJpQkFYd2Iv?=
 =?utf-8?B?ODlZM2loOXhoVkcxK0J5aGh4ZWVrbEptaTNoT0E1SUZTUUZsNC9ndnJ6NXZF?=
 =?utf-8?B?RHFiSEVXbkVYNEJtdHNUejY5OUlmcU5YV1BUdGFTR0dGd3NjMjJpNnE0eUs5?=
 =?utf-8?Q?aV7U9pJWl2bis73k9TBXaWRCr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf87275-aa90-4824-79ea-08dbc8f7b0f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:43:55.5596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RuJ5jf8JLLRUT6sw39usxpTFRJII7gYyMLNUdaOoFdhU94ZuEqF5IVWFqQI7BeOXGi4Zr/ybVjz/d9AaN1j+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/9/2023 13:40, Alex Deucher wrote:
> On Mon, Oct 9, 2023 at 12:52 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> amdgpu_switcheroo_set_state() calls lots of functions that could
>> fail under memory pressure or for other reasons.  Don't assume
>> everything can successfully run sequentially, and check return codes
>> for everything that returns one.
> 
> I think the reason we do this rather than returning errors was not
> because we assumed they would be successful, but that it seemed better
> to try and restore the hardware than to bail early.

OK.  If no other feedback for the series I guess for now I'll drop this 
patch from the series when it's committed.

> 
> Alex
> 
>>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 +++++++++++++++++-----
>>   1 file changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 0f98f720d9ca..65a4537ee6f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1749,23 +1749,45 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>>                  /* don't suspend or resume card normally */
>>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>>
>> -               pci_set_power_state(pdev, PCI_D0);
>> -               amdgpu_device_load_pci_state(pdev);
>> +               r = pci_set_power_state(pdev, PCI_D0);
>> +               if (r) {
>> +                       DRM_WARN("pci_set_power_state failed (%d)\n", r);
>> +                       return;
>> +               }
>> +               if (!amdgpu_device_load_pci_state(pdev))
>> +                       return;
>>                  r = pci_enable_device(pdev);
>>                  if (r)
>>                          DRM_WARN("pci_enable_device failed (%d)\n", r);
>> -               amdgpu_device_resume(dev, true);
>> +               r = amdgpu_device_resume(dev, true);
>> +               if (r) {
>> +                       DRM_WARN("amdgpu_device_resume failed (%d)\n", r);
>> +                       return;
>> +               }
>>
>>                  dev->switch_power_state = DRM_SWITCH_POWER_ON;
>>          } else {
>>                  pr_info("switched off\n");
>>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>> -               amdgpu_device_prepare(dev);
>> -               amdgpu_device_suspend(dev, true);
>> -               amdgpu_device_cache_pci_state(pdev);
>> +               r = amdgpu_device_prepare(dev);
>> +               if (r) {
>> +                       DRM_WARN("amdgpu_device_prepare failed (%d)\n", r);
>> +                       return;
>> +               }
>> +               r = amdgpu_device_suspend(dev, true);
>> +               if (r) {
>> +                       DRM_WARN("amdgpu_device_suspend failed (%d)\n", r);
>> +                       return;
>> +               }
>> +               if (!amdgpu_device_cache_pci_state(pdev))
>> +                       return;
>>                  /* Shut down the device */
>>                  pci_disable_device(pdev);
>> -               pci_set_power_state(pdev, PCI_D3cold);
>> +               r = pci_set_power_state(pdev, PCI_D3cold);
>> +               if (r) {
>> +                       DRM_WARN("pci_set_power_state failed (%d)\n", r);
>> +                       return;
>> +               }
>>                  dev->switch_power_state = DRM_SWITCH_POWER_OFF;
>>          }
>>   }
>> --
>> 2.34.1
>>

