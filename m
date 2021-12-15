Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877F9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 15:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0261210E4F4;
	Wed, 15 Dec 2021 15:19:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D7510E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 15:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhyLXcj4iRNpO9dR/H7mg3zlL6WEZE1jNWBDz1x70IXmoa8HSGjOa9pHhtOxVK2EEra7K1Kg/D3c5TatsC5lxis3KoDl8w7ZSQ0ivCQFqnlkgpNHbP9Sl8K5rRI7kbTY0HFVwy1rY3k8PrITuzTxYFHymQ72uoQeyKyNlFEPTx2aJdqf9dPXFHKllfxAgtpwQiz2kuV6RGLBEBxq003eT0UM05P53mKgF7UxTgf+um3o63F5sD0d/KCdJtaA2YGwG+SeH5IM97JKXEYRzWOCRJ5+QtsnuuDiJM8nJebVMY78soiEFJcotQuF00tX2vuh0n1HAdCM9eQubFYSDtNnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3I7jG5D26ymIykur6TxymqxoXKf+draIxZFOkvDrq4=;
 b=dln4lPSrhuzEA96OLNRKFA3pb/J57WtEvA849uA6wkNS+gXCEmwllHmSb4eYgALhRN7CSuV4uEvdkfq+gJqN8ROvqqM8dXlH3NwzjkJ2L2C+9TByE8fRCPJASthpmQ3FkOK6x0TJMP+xvZ3r7xGbBaqiaMGRImGUgdvhrlifnt7RB+SkQz3iBe5/v+JJwgo7UK8qzrZIyot1gPOJjRaoBQzLbssQuiICJoInrlYSkN0fr1MG9WW6JsU/Rhyl5WvR9uGMFcsZYxRsEKz5GEoSdZVR6MWZijNJ1H68/yl5yK1xTAu6sTBSeHaRT95S8NN1e7mDskIM+UXF0ZOHZcSkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3I7jG5D26ymIykur6TxymqxoXKf+draIxZFOkvDrq4=;
 b=gOOmSKdD51wVvHc098uGTJjf1Bftlo6+60TGQwZCSE1Q+N/FJ/sEhioQ95DZ8wbPIlx6oBhDZQpM4g3HP/3WSOxfv9Umzk2td68dsVQljRwCeV6lLKVaYFcFsey12fHQHjg07G8JxpA/dzLu95I+8qtvE+FCB+ng3hRQ5tkU29w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 15:19:38 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c%7]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 15:19:38 +0000
Subject: Re: [PATCH] drm/amdgpu: add drm_dev_unplug() in GPU initialization
 failure to prevent crash
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211215084636.2133355-1-Yuliang.Shi@amd.com>
 <a8f7b8b6-669c-86b8-78eb-e08e6ce147a2@amd.com>
 <DM5PR12MB2469E068544B0A422872FDB2F1769@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <6ce134cd-e0aa-661f-d994-f3076acbb114@amd.com>
Date: Wed, 15 Dec 2021 10:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB2469E068544B0A422872FDB2F1769@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b2e4bea-8674-43c0-daa7-08d9bfde4f49
X-MS-TrafficTypeDiagnostic: DM6PR12MB3484:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3484C093DBCAA6D329DA9135EA769@DM6PR12MB3484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOhYqJsFd23p+4nJkb2/6u/IKbcY67DFk61X9tYh4w0gyTHaLPW9ojBDY4QDWneJakg2FoyNG/IoaxPv0p7VJKH9v47dBwOrrEfIx16rdrkk9x/H4FKpRxxwLlL3VXwhSgY4rv6at5mOhpx83ZnT9L/qlrFEWnLHfHGWGEu9+dF0igpInMYeLUenn9hFkWKaXvU745JUEyx6/QEaXumPQljBeHiVLmpmxDvlqeX6DCo4d/Ss7eNqXv/ytIOK22xnOKVblDh2x/TnhDmq/9pvar8Ov1fZOw0HkHW0jlOy5R4DeDXhrH7gWOOPqwcRTo7OUEsKS7iMC3b8301GidI3cHh9gAtUvJsinJeszDFrAVePJPSoO66br9U4MpMJG4y/cILpegxxncpCHdPmk8dtd7ttrBf2u1Jlkh35p1XE/xYgkKJFG/dw9gTyvgzOnswhx2BISshyZ89vXsElYCfMRbXnPtEYowUVdfmUlGxdDmq2zwGaL+Oz7LBYPI4ECCXyrwU2YPro8P5V9tJX+0Xb50wa8GN3MmHg/4FD5ZH0GA1YkqpAsB4oNSj1yvnTEUTJj7ipYMZFU/ufI4wkQKm0JJp9SSTTYTD2z8xaExyeSUy4LDszFTWQa7VSM7lNLOwUsoBvR9DW5vLphajyMC+ohAvWw6u2g26ZkhpA3z7i3z0mJhpGbjT7VGyBUomv5z8M7iP4iLca5uoUd3eUZ85Wg+xqSiM8J03FrSIajL4trXDD1MeMSQMc67z8bxxaiccym/0U/3VUb3A62o0MzSFHrYLYZ/OTV9mLvuD8ZxKAqOu+XMB6nCzyUcQ6PpMludX/ZIFf4fOwKpQprmjlPnpzxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(83380400001)(31696002)(4001150100001)(36756003)(6666004)(316002)(5660300002)(8676002)(8936002)(44832011)(508600001)(86362001)(38100700002)(6512007)(2906002)(53546011)(6506007)(110136005)(921005)(66946007)(66476007)(186003)(66556008)(6486002)(2616005)(61000200003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JEMThhTmRSNDl0M09VRW9mOG9WdmVnU1JaS0VHV2FGcFhZV013Ykx1b29x?=
 =?utf-8?B?T1MzWGd3azVVOXdid3dqcDhicCtraHpZSGFsdWh5aENydGtLcDRLM1pkVVlv?=
 =?utf-8?B?RVkzUlVGUGJtYnhMam56MUxISGNKZW43bkN4NDJvYmh2RDdKL21wbW8rMVE5?=
 =?utf-8?B?ZFI3NU5kS2NuOHRndVhic1JJNTFXRWphRHp6LyszMzBib0RQSDNxMHlid3ph?=
 =?utf-8?B?SGdEVDlialZTYXhHNDV5RDE2eCtNcmVFajg1NVc2U1NVOUtscC9LYUpKMU9H?=
 =?utf-8?B?MjJUcmxRRVhhUDdKdTkrYThVK0dwUFdBaWl6bWxQcXpuK0pFczJPWlBUaFhs?=
 =?utf-8?B?dWJaWUdUQmdYaEJseEZ2bTRvZWNrUlFNMW53UWk5NFBhaSs5THRTY0VCK0o4?=
 =?utf-8?B?eHBjSUZNdjhNMmJLTDFzNTczeUJGZFFvWHZqcFNqbFpGWWs4YlhCNHN3UzJ0?=
 =?utf-8?B?azM5UEZ2cS9MSkpKdEFibldKYTVSd29jSnd3dGhyQzliNTVWZmFnVmlhc3lV?=
 =?utf-8?B?eWptYldONUQzVlQ5SUg5UXN1dVFBYjVMNjhtLzVJWU8xWDNqSUVGbmpLSkRo?=
 =?utf-8?B?U2kwN2VCdjZCZzI5cXNhcVVTSmMrU2gvYkFIYy9PN1JpWmI3M2pQU1ZzU1pW?=
 =?utf-8?B?Nk5XK240Q1VZOXI4VlFpMTRPWTA3cjZxbWNFRjZnUElhN0dFc3dVT1JuM1VK?=
 =?utf-8?B?azZob0J0T0JXelRQS1RWMlR2ZUd0SzdCVEprMlg5R2RwZ1o0Q1FySHFVWEsw?=
 =?utf-8?B?T0x1UkZKTG03emJWNkpyb20rdUY4S2lYUFdScVVVWCt0K3FyWFFjRXkyUFM2?=
 =?utf-8?B?VEIyMEhIamdKRkpGazA1b3RhSTVVYzgzSzh3YjAyWCt2TXh5cjlDZE5oeEZZ?=
 =?utf-8?B?R0tHQnEyUzQ2SVZ3ZUkzU2V1ZEdqUmt1SSt3bDZjRno5dElUcjlSZmpTMFBQ?=
 =?utf-8?B?c3V0TXdPdFNpYUFucFo2SHhLeWh4Z0h4TXY4cWdLMnVhNTNTN2x1T3JtTFNz?=
 =?utf-8?B?aWhlZW1RZm5UV1dqL0VxQTZRM2p4TXRRdHpCMXhXMUxKZGI1RTBTU0kzbU9i?=
 =?utf-8?B?SnI5TlArTG5SRnhxbmtlbWZLZlJkZnU2TndiMFkzRWVOUmFIYnVjTkR5MDRa?=
 =?utf-8?B?cmlBaXFSV01TQ0JaVk9hRVU2ZnRNcFB2WHNGWXVWMGRZTmFRdGRaWWJLQmln?=
 =?utf-8?B?YmYxblU3eE9TVlZvN1pONzhWbmRwSzY3TmJzVU90aUJOaW5PZGhXT1JYMTJD?=
 =?utf-8?B?bzNpWDhuK29ydVRGRStrMGN0U1hTckt3MU1TeVFqZmdjV2p3eGlFSlhQU2J5?=
 =?utf-8?B?Y2gvNllEVFlIbnh5bitmREIwdHZPdWF6UnBNcUpzSStjRyt6Ym0xSU53L1p0?=
 =?utf-8?B?VGRQdnBzWHh3OURlcE1XU3o5Q0dUWCsxTExVY001Y1FsZG9xUTNnVEZCdWJt?=
 =?utf-8?B?OWQ0b1ZGc3h4clYvTjR4c3l1bjBTNHZBRy92NEFhbkM1V01HZlNIMzNxSDMy?=
 =?utf-8?B?VDZlVTA4dVFwUUFpcG9jVEdjd05wVjVlOGNoRkYvT042T1pxZUtXdHJsQktv?=
 =?utf-8?B?NVdhYXNqaUNHZnZSSzdaZEFWS1VBSFlGLzNDdEd0OFBMTzNHUmN4YmhQSDRK?=
 =?utf-8?B?dDNVRG9ScFVhWDdlMHM1NGRKbjAxVVA3eXpkemFyM2pCc3htblpkUnBCekdy?=
 =?utf-8?B?M0thdEI3RHF2OWg5MXJTbkxxai9jeVloM21tU0p6Q3N3cm0vUyt2WXdTZEVS?=
 =?utf-8?B?bTkzaGFXNFlUUzFiakV5eWJCNWpaZ2JXUFVnZm9UOCtLRnUzYnM0elV6dUg3?=
 =?utf-8?B?TXpwMXduK2JjOUlNL3ZjRHhEdlpqRmxMWkdVdjlYc0xQZjh6Nkc0M1FETldk?=
 =?utf-8?B?TFp3b3FyNzhjeCs5S3BXbGZhc1dwZ2lPTlViVTk5eWplRkNjM0lhWGZndmxv?=
 =?utf-8?B?MmRIb2VQZHRtVjVtbTVlWWJkNXA5ekcyR0VFS3pNa2lRMEowZHZqOEIvb3A5?=
 =?utf-8?B?YldqYlk2YThIK3MxTzJUOTBQMkx1QVZpNW0rVEd5NG5PL1RFQVJDdHlPLzBL?=
 =?utf-8?B?S3k2NEdTUlAzTEEwaFVFOEhSTHNDbnpnK0N4emhKUGpTbTMvNjNaZTZlVGxL?=
 =?utf-8?B?YlMxQXZJY0JKa2prL2pzVzFCZEFJUTQzODdOTmFaUDVTaTdBN0pkU3QzdTNk?=
 =?utf-8?B?MUExL2VjclhmV3lUZ0plcUxjNHpVOW1LYWx0Q3hmY096YVJHRkRqbVArMHNT?=
 =?utf-8?Q?KGagawL8qMtxYeWBcfKKuXeKiN/jJYHmCpb+u7Sf70=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2e4bea-8674-43c0-daa7-08d9bfde4f49
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:19:38.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+bf5ZjsNdKNdj/pq7QuOTo3f2xUIVLkNamyy9UDtE/13J9v5+icqn6lvxqLgLq3XxYmxXYX1iMkuOg/I5Hcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
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

I think that we should not call amdgpu_device_unmap_mmio unless device 
is unplugged (as in amdgpu_pci_remove) because the point of this 
function is to prevent accesses to MMIO range the device was occupying 
before removal.
There is no point to prevent MMIO accesses when init failed and we want 
to do an orderly HW shutdown... So probably we should just change to

if (drm_dev_enter()) {

     amdgpu_device_unmap_mmio

     drm_dev_exit()

}

Andrey

On 2021-12-15 8:28 a.m., Chen, Guchun wrote:
> [Public]
>
> Hi Christian,
>
> Your question is a really good one. The patch to unmap MMOI in such early phase is from Andrey's patch: drm/amdgpu: Unmap all MMIO mappings. It's a patch half a year ago, and everything looks fine till this case.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, December 15, 2021 7:00 PM
> To: Shi, Leslie <Yuliang.Shi@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add drm_dev_unplug() in GPU initialization failure to prevent crash
>
> Am 15.12.21 um 09:46 schrieb Leslie Shi:
>> [Why]
>> In amdgpu_driver_load_kms, when amdgpu_device_init returns error
>> during driver modprobe, it will start the error handle path
>> immediately and call into amdgpu_device_unmap_mmio as well to release
>> mapped VRAM. However, in the following release callback, driver stills visits the unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.
> Mhm, interesting workaround but I'm not sure that's the right thing to do.
>
> Question is why are we unmapping the MMIO space on driver load failure so early in the first place? I mean don't we need to clean up a bit?
>
> If that's really the way to go then we should at least add a comment explaining why it's done that way.
>
> Regards,
> Christian.
>
>> [How]
>> Add drm_dev_unplug() before executing amdgpu_driver_unload_kms to prevent such crash.
>> GPU initialization failure is somehow allowed, but a kernel crash in this case should never happen.
>>
>> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 651c7abfde03..7bf6aecdbb92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -268,6 +268,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>    		/* balance pm_runtime_get_sync in amdgpu_driver_unload_kms */
>>    		if (adev->rmmio && adev->runpm)
>>    			pm_runtime_put_noidle(dev->dev);
>> +
>> +		drm_dev_unplug(dev);
>>    		amdgpu_driver_unload_kms(dev);
>>    	}
>>    
