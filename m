Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA0EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 16:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E4110FFF7;
	Wed, 11 May 2022 16:49:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE43F10FFF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 16:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URgyWNfoTI20kNC+Oi0xMPI0ALeVEZdm+TJtgMGbNvaMDMfcJarVu+4EJWBlw0jtHoF2r/sNLhMIIB1Oyl291HPdjbNEBob7l9i9t7FIR/R/hjHXxNH+poGnz/SVPW5GD4EFZ498cqI0TmondMzvxnOsleEsJSRJWqZ9kthOuStN/psCde4cxxwO337Sny31NDAG0HTPzgb+SwfmwWeVUtEcIlecsR4fOCS8J+GhtJyxZPejBZpLG39qTS/8doIKYDOg7In1J4q+gbru9pVZ1z8uVrSh2ySYSRU1OvJ5aLkNt4Swr1jOcfOtQ88ZJHkeV3SIrDDIZaLghFDFAMtXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jia5X+Fig3ysqHW3+SfDtcF0aSlVPPzH1TYMGTBOjxU=;
 b=SN9rETAMe/ali4STBTQzINlW6LwqAjFwOOpW0/YxmcGuJCRPFfEmlAmYABfGUoVTYlyRgu3/i2B5PonR+GSx24ZXFs5O+4CjNIRuTd//oMqU5qUba9pKNmlSvs7LA7VIiZjLFhTULAaSb6YL9lfUKNu/9nIxfxx0YEjyd9jDQJSsmVgXS72BgSoHSIj7gqK1LkStzL4ZkY9/fI8oNBwtOTZ9ZdzcL2p8+d4WssvuUtbvPXurHiutjmNgRgqauI/2b0HRPN/ZTWsY6C6BCO+jS5Ns6LzB74tTJo2otL3Jo75W6WMK/Vr1py6EnSKdN4QDtJmqfdlyoex1gqv10P0wXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jia5X+Fig3ysqHW3+SfDtcF0aSlVPPzH1TYMGTBOjxU=;
 b=13+84DU3sXnXKEuPg6D1nW5i21d9khnsVqBIAawwxzmNww6+pDr28LNdGqVXKuZoSZQTH2GiTZDJb+EkcSwBIIOaY9Gi7/Ou57zwi3GOomMAMAlft7u3buq9S6xPc9Bv4fIkYAjdNw3JGw/HP7SdM65mIgtxZgiU1PVOFXypAXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Wed, 11 May 2022 16:49:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5227.024; Wed, 11 May 2022
 16:49:16 +0000
Message-ID: <b542b53d-0714-b72c-2116-6061e162e813@amd.com>
Date: Wed, 11 May 2022 12:49:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
 <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
 <549246A3-B326-47CC-92FD-608708E1876B@microsoft.com>
 <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
 <0d99be40-f6b9-b191-feca-d74344f03bf2@amd.com>
 <FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com>
 <66bf32d5-1636-ecdd-8a49-24c6254079bf@amd.com>
 <E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com>
 <15805b62-2e43-b469-0816-1083c5e76acd@amd.com>
 <E51808D5-5E34-420C-9CBD-F2BAE26E45F5@microsoft.com>
 <bb0fb1df-af73-8390-20e0-8d34078b6419@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <bb0fb1df-af73-8390-20e0-8d34078b6419@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3409afb2-76b1-4349-c5c6-08da336e2f70
X-MS-TrafficTypeDiagnostic: DM4PR12MB6159:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6159CDBBCD91DB1F81E2CC2592C89@DM4PR12MB6159.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PvGa2vX+a5sfSWLmcoyC5MElUQ2LxAy3pzB16DAQC73plFe/KRLswO4zWutqZGmM/qFTsw37B/z3z2tLMgl5OuuW71sVoGvotYic1YCjeq8myhIHqicU5eWaNTmFXpwDz5lUQQval68O6po/1AuraHzYXgxuvTN71P0BgYWSk5hJLYZJQsevyCXTL3qFjYyijAMqf55EqXlYQy4apY6ZslFexpZUZK7ifF3+EDBh0EFCGvX5MGmv9KPN99BRGMwTG+Rs21r3d0vkKKt7uEc+KnuEJii7ZKLhHUHlhRBJpXP/SNge/RdKvI3F32QFwWOyYB9DQ+p/hfDvKUEEHrjIFg6p4QLYtOt2ooZ5jWj0vcFA41BzAdwzAd7ml9SAPfH1ZO+cBsPu3k+x0vgrnsR9l7OTyXzv+4RKB3HkeTYPxnkk6wdz1vmfmWhUKDi9FnC9JjVPR/30aONIGm85NWt+XlKlvjo/RZAV06Lbelfu3ydycXTfmIrPY0NcKizxPEBscRf+Fr8vKwjF2ICdEe4Geqt9gIIfZw5EW6M8Sx0P33kgxzcTJp6nNjjwBJxNGdMzw804o323QOfycUHQAO1WIqxfoTysT88dWGGq9h+rYkNLcBOab628Gvsxe6NIZnjk+jMns9z/AhDH/958qw5AAEoPGcGJCDEvRERWIbISQdRrLSAXAnVHQCInaW3r0oTJl54JB7wAd8g9KBFsNXPm5qcwa/BV7kKlKsUna2hce9lR8qV/H0aphoTM1i0W70ibIZSWKeoZ209dQUd5tYIUsmNWbHojQCLZ2sPoUl6UrVCMO/WCWez+lPggOdrTZlN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(45080400002)(36756003)(2616005)(86362001)(8936002)(53546011)(38100700002)(66556008)(54906003)(316002)(110136005)(66476007)(66946007)(8676002)(4326008)(31686004)(2906002)(83380400001)(508600001)(6486002)(966005)(44832011)(5660300002)(30864003)(31696002)(6512007)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FhUS96a2sycm9EOFZXTVA4d3Q5OXFEaEZyREgrRVVScVBBVmRSR3RaK3hx?=
 =?utf-8?B?KzZ1eGR2NHBveGFldmVzSGxQTHMwWTZFdHpxdFB4ckpmWi9Td0pCRWpNMDRV?=
 =?utf-8?B?Rm01a2VGMXIzaWo2TnA1d3pUUHFVb1laSHdzRVFPNDNnMjd2SmhEaVhxcTk5?=
 =?utf-8?B?OEFPS28wVkNOcVlacW5ORXlUTnlscFFiSHhWV05EaEtFMlZiSUlUb213WUhq?=
 =?utf-8?B?WWdEdlNDenRPNFNHbVlCT1h0U3V0OVU0QWNVOWZkSUc5UEgvSFpjMTFhd0hP?=
 =?utf-8?B?UGlZRHRrbXBMVHZOQytUM0FtZmw2QUxqUDdrN1Zmci85MFNnbGRRZVJQOEZL?=
 =?utf-8?B?cUlUT09talB0SnJhTEIwNE9rcm8zQytnVTdFNTQ3cFgxbkNCanlnQ3k3azVt?=
 =?utf-8?B?VXRxb2VjMGVxcEM3QXdsMVh0b2k0SjZ2cDBZZkVIZjFsamI1cThjTVhhYUwv?=
 =?utf-8?B?YjY5a0s4aGg2OHRKRWdKV1MyTzZkTzUzV3d1WnRMOXlTSWpFZ05kWTUzK3Vo?=
 =?utf-8?B?THlkYktub2lURXJ3TC9BdGttWUZaajA4YzFJYm1TTmhKaTV0a1BrZFhIYm1E?=
 =?utf-8?B?dTBzVEN1djdhd3pwSGNjcXZsMUF1cW1lNGZaRDdUTGlTelpjK0VKb2lOYWdD?=
 =?utf-8?B?WTRmR1Q5c2txa2xVeGw5YWNZVkNpK2ptZGVTRGZXWmt1ZnhUUmpOdDBhcjFJ?=
 =?utf-8?B?WE9FMnUzSk4yNit5R05WQlY5SStTRTcwWWkxVk4vd29lVnNkc0hGQTZSVk5z?=
 =?utf-8?B?MFFxdXp0MWFjS1ora1dlOVNVUzBMc3RvTmlyanhhMHp5cldsRE5ZSVZUZEgw?=
 =?utf-8?B?NTI3UHUyY1RpSUJmZEcwZEp1SFdOemZ5eEM5dmhaZHlYZ3V6TUdFV2FTY0Mz?=
 =?utf-8?B?K0c0RmZrR04xOWkvaXNCTVhSdHpOb2tFa3VLdGpvOGZnVXlPTWQrUFBlNXJo?=
 =?utf-8?B?ZGtqUERDVVdjRGRqa05vMWloTXNDdGtIUGxRdmVFK05xWlBaUElLN0tyNTEv?=
 =?utf-8?B?anVFd2hCclpDZDBEdlIrclNYUG53MVRkcGc4cnB1VyswL2VCajJYNlQrek1T?=
 =?utf-8?B?aG55VGcwUVpYbUV6OWhnK2tjeDVxYlFpY01Mb05GZ1AvYlBsbXJKMGUrbGVX?=
 =?utf-8?B?MEZrSnh3M1VUbVU3c1ZBU2xTQnVwcVgvdUM2RjloNWdENWZSOWxxaXc2eTFa?=
 =?utf-8?B?RkFrRU5URUVjZmRnd2ppTVJBdFNsYm5qbWdXRmF3Smh0d0orQWtNL1RtaC83?=
 =?utf-8?B?TjJ0d2V0OWtSSzBnZGozVVdsbEVYOWFDNGR3US80MlJYMkg2dnFoMWUxYmw1?=
 =?utf-8?B?QncwUW5MUHFSR0xSemhibFRJc2w1ZHI2YjZRaUcyRDhUMUV3THkzZVkwc3ds?=
 =?utf-8?B?U1FmWWFxaTU3d1ByNjdKbmJFNy90SzU4eFl6R0FML0Z5ZUFteHdlL1hoRjhn?=
 =?utf-8?B?V09IbFlYNlZzWWM1Y21DTG5kVjZTR1RheklCamRQM1ZHVkh0R3ZaejNScFhu?=
 =?utf-8?B?VW82bFpsaFFBTGdacTRtcWhPNWxZZXpEdy9wd25wMzRXZ1ZIS0hnWUpTTC9z?=
 =?utf-8?B?QzhEYmtacGVNTkkrczAwTUo0Nk1WMlY1TEppMkJLOHVlbm9DN2ZWZ3d4eDho?=
 =?utf-8?B?OExmM0RTalVKQjdpeUdldDREZ2ZNOU9JZnVHamJzR1hYaHc3cU9nVnY1dGdi?=
 =?utf-8?B?OEZBTHlmK3Fad3NldEdNZlI0RytPNURtdkJtZUtrWHV6bmxoUFdjWWdFTWdN?=
 =?utf-8?B?eHlyeUNpRy9DbFNGbGlmUnB0MU9QMHkyZ2tQa0xkaHp4clo5WnhlS1ExakRJ?=
 =?utf-8?B?NWEvQ0IySUpOMk5SNHZ2UUNGczhIRTg5RzRZTXZTcFhYUVNNdGVtbGdTcHY0?=
 =?utf-8?B?Nk8weEZSZlJyQ1c2VkExaGFEQTAxbDVCZC9aaG1lR0wwRFVmeGE0UzA3c05h?=
 =?utf-8?B?eFpZbUQrRmRhcVVabm9WSVp6bHhzSTR5eDgwcGVNUHJTZjhGTEJkdU9sanhR?=
 =?utf-8?B?dnRURm9wQTliUnkrWS93bDFHbG9Jc1JZUmx4ZEtXUUI4cVlVUU1HaUlUVnJJ?=
 =?utf-8?B?VlV6SnZmN2Y0dUJPQmppemFNMmY3WDBubW5OVnB5MjBvd3loRDRUVFNnOGFP?=
 =?utf-8?B?M3YrOFdPL0VEOFZ6VVhkeW45Sitic2VIcDdmUDVWWlJLOWxibnBCL3dVVmZE?=
 =?utf-8?B?YzBGSk8ycjJvTlpZd0dPUWdLbGxGMHFqRC83MEhzbVVLVDBmUXVYQ3ZhL1VB?=
 =?utf-8?B?Mm81Qk9PM0I5MVhMY2h1dXRZUHd0cysraCsvSTBiZEJReTNWTlNXdnNUSkkw?=
 =?utf-8?B?NHRQZzltbmx0dmphRFFOQkc0Sk8zQ1BlaGNZVXNzSmRtUndpa1ovUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3409afb2-76b1-4349-c5c6-08da336e2f70
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 16:49:16.3403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJMosQms25XkSD+zvI8PUkw1edbkwgkdyH96bCwLvR5oK/Jh8nAvMn7sx1Vue8/nXjgMsSykjj9JWKxDKCdt3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>,
 Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-05-11 um 09:49 schrieb Andrey Grodzovsky:
>
>
>
[snip]
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index f1a225a20719..4b789bec9670 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -714,16 +714,37 @@ bool kfd_is_locked(void)
>>>>
>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>> {
>>>> +       struct kfd_process *p;
>>>> +       struct amdkfd_process_info *p_info;
>>>> +       unsigned int temp;
>>>> +
>>>>        if (!kfd->init_complete)
>>>>                return;
>>>>
>>>>        /* for runtime suspend, skip locking kfd */
>>>> -       if (!run_pm) {
>>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>                /* For first KFD device suspend all the KFD processes */
>>>>                if (atomic_inc_return(&kfd_locked) == 1)
>>>>                        kfd_suspend_all_processes();
>>>>        }
>>>>
>>>> +       if (drm_dev_is_unplugged(kfd->ddev)){
>>>> +               int idx = srcu_read_lock(&kfd_processes_srcu);
>>>> +               pr_debug("cancel restore_userptr_work\n");
>>>> +               hash_for_each_rcu(kfd_processes_table, temp, p,
>>>> kfd_processes) {
>>>> +                       if (kfd_process_gpuidx_from_gpuid(p, kfd->id)
>>>> >= 0) {
>>>> +                               p_info = p->kgd_process_info;
>>>> +                               pr_debug("cancel processes, pid = %d
>>>> for gpu_id = %d", pid_nr(p_info->pid), kfd->id);
>>>> + cancel_delayed_work_sync(&p_info->restore_userptr_work);
>>>
>>> Is this really necessary? If it is, there are probably other workers,
>>> e.g. related to our SVM code, that would need to be canceled as well.
>>>
>>
>> I delete this and it seems to be OK. It was previously added to 
>> suppress restore_useptr_work which keeps updating PTE.
>> Now this is gone by Fix 3. Please let us know if it is OK:) @Felix

Sounds good to me.


>>
>>>
>>>> +
>>>> + /* send exception signals to the kfd
>>>> events waiting in user space */
>>>> + kfd_signal_hw_exception_event(p->pasid);
>>>
>>> This makes sense. It basically tells user mode that the application's
>>> GPU state is lost due to a RAS error or a GPU reset, or now a GPU
>>> hot-unplug.
>>
>> The problem is that it cannot find an event with a type that matches 
>> HW_EXCEPTION_TYPE so it does **nothing** from the driver with the 
>> default parameter value of send_sigterm = false;
>> After all, if a “zombie” process (zombie in the sense it does not 
>> have a GPU dev) does not exit, kfd resources seems not been released 
>> properly and new kfd process cannot run after plug back.
>> (I still need to look hard into rocr/hsakmt/kfd driver code to 
>> understand the reason. At least I am seeing that the kfd topology 
>> won’t be cleaned up without process exiting, so that there would be a 
>> “zombie" kfd node in the topology, which may or may not cause issues 
>> in hsakmt).
>> @Felix Do you have suggestion/insight on this “zombie" process issue? 
>> @Andrey suggests it should be OK to have a “zombie” kfd process and a 
>> “zombie” kfd dev, and the new kfd process should be ok to run on the 
>> new kfd dev after plugback.
>
>
> My experience with the graphic stack at least showed that. At least in 
> a setup with 2 GPUs, if i remove a secondary GPU which had a rendering 
> process on it, I could plug back the secondary GPU and start a new 
> rendering process while the old zombie process was still present. It 
> could be that in KFD case there are some obstacles to this that need 
> to be resolved.
>
I think this may be related to how KFD is tracking GPU resources. Do we 
actually destroy the KFD device structure when the GPU is unplugged? If 
not, it's still tracking process resource usage of the hanging process. 
This may be a bigger issue here and the solution is probably quite 
involved because of how all the process and device structures are 
related to each other.

Normally the KFD process cleanup is triggered by an MMU notifier when 
the process address space is destroyed. The kfd_process structure is 
also reference counted. I'll need to check if there is a way to 
force-delete the KFD process structure when a GPU is unplugged. That's 
going to be tricky, because of how the KFD process struct ties together 
several GPUs.

Regards,
   Felix


> Andrey
>
>
>>
>> May 11 09:52:07 NETSYS26 kernel: [52604.845400] amdgpu: cancel 
>> restore_userptr_work
>> May 11 09:52:07 NETSYS26 kernel: [52604.845405] amdgpu: sending hw 
>> exception to pasid = 0x800
>> May 11 09:52:07 NETSYS26 kernel: [52604.845414] kfd kfd: amdgpu: 
>> Process 25894 (pasid 0x8001) got unhandled exception
>>
>>>
>>>
>>>> + kfd_signal_vm_fault_event(kfd, p->pasid, NULL);
>>>
>>> This does not make sense. A VM fault indicates an access to a bad
>>> virtual address by the GPU. If a debugger is attached to the process, it
>>> notifies the debugger to investigate what went wrong. If the GPU is
>>> gone, that doesn't make any sense. There is no GPU that could have
>>> issued a bad memory request. And the debugger won't be happy either to
>>> find a VM fault from a GPU that doesn't exist any more.
>>
>> OK understood.
>>
>>>
>>> If the HW-exception event doesn't terminate your process, we may need to
>>> look into how ROCr handles the HW-exception events.
>>>
>>>
>>>> + }
>>>> + }
>>>> + srcu_read_unlock(&kfd_processes_srcu, idx);
>>>> + }
>>>> +
>>>> kfd->dqm->ops.stop(kfd->dqm);
>>>> kfd_iommu_suspend(kfd);
>>>
>>> Should DQM stop and IOMMU suspend still be executed? Or should the
>>> hot-unplug case short-circuit them?
>>
>> I tried short circuiting them, but would later caused BUG related to 
>> GPU reset. I added the following that solve the issue on plugout.
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b583026dc893..d78a06d74759 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5317,7 +5317,8 @@ static void 
>> amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
>>  {
>>         struct amdgpu_recover_work_struct *recover_work = 
>> container_of(work, struct amdgpu_recover_work_struct, base);
>>
>> -       recover_work->ret = 
>> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>> +       if (!drm_dev_is_unplugged(adev_to_drm(recover_work->adev)))
>> +               recover_work->ret = 
>> amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>>  }
>>  /*
>>   * Serialize gpu recover into reset domain single threaded wq
>>
>> However after kill the zombie process, it failed to evict queues of 
>> the process.
>>
>> [  +0.000002] amdgpu: writing 263 to doorbell address 00000000c86e63f2
>> [  +9.002503] amdgpu: qcm fence wait loop timeout expired
>> [  +0.001364] amdgpu: The cp might be in an unrecoverable state due 
>> to an unsuccessful queues preemption
>> [  +0.001343] amdgpu: Failed to evict process queues
>> [  +0.001355] amdgpu: Failed to evict queues of pasid 0x8001
>>
>>
>> This would cause driver BUG triggered by new kfd process after 
>> plugback. I am pasting the errors from dmesg after plugback as below.
>>
>>
>>
>> May 11 10:25:16 NETSYS26 kernel: [  688.445332] amdgpu: Evicting 
>> PASID 0x8001 queues
>> May 11 10:25:16 NETSYS26 kernel: [  688.445359] BUG: unable to handle 
>> page fault for address: 000000020000006e
>> May 11 10:25:16 NETSYS26 kernel: [  688.447516] #PF: supervisor read 
>> access in kernel mode
>> May 11 10:25:16 NETSYS26 kernel: [  688.449627] #PF: 
>> error_code(0x0000) - not-present page
>> May 11 10:25:16 NETSYS26 kernel: [  688.451661] PGD 80000020892a8067 
>> P4D 80000020892a8067 PUD 0
>> May 11 10:25:16 NETSYS26 kernel: [  688.453741] Oops: 0000 [#1] 
>> PREEMPT SMP PTI
>> May 11 10:25:16 NETSYS26 kernel: [  688.455904] CPU: 25 PID: 9236 
>> Comm: tf_cnn_benchmar Tainted: G        W  OE   5.16.0+ #3
>> May 11 10:25:16 NETSYS26 kernel: [  688.457406] amdgpu 0000:05:00.0: 
>> amdgpu: GPU reset begin!
>> May 11 10:25:16 NETSYS26 kernel: [  688.457798] Hardware name: Dell 
>> Inc. PowerEdge R730/0H21J3, BIOS 1.5.4 [FPGA Test BIOS] 10/002/2015
>> May 11 10:25:16 NETSYS26 kernel: [  688.461458] RIP: 
>> 0010:evict_process_queues_cpsch+0x99/0x1b0 [amdgpu]
>> May 11 10:25:16 NETSYS26 kernel: [  688.465238] Code: bd 13 8a dd 85 
>> c0 0f 85 13 01 00 00 49 8b 5f 10 4d 8d 77 10 49 39 de 75 11 e9 8d 00 
>> 00 00 48 8b 1b 4c 39 f3 0f 84 81 00 00 00 <80> 7b 6e 00 c6 43 6d 01 
>> 74 ea c6 43 6e 00 41 83 ac 24 70 01 00 00
>> May 11 10:25:16 NETSYS26 kernel: [  688.470516] RSP: 
>> 0018:ffffb2674c8afbf0 EFLAGS: 00010203
>> May 11 10:25:16 NETSYS26 kernel: [  688.473255] RAX: ffff91c65cca3800 
>> RBX: 0000000200000000 RCX: 0000000000000001
>> May 11 10:25:16 NETSYS26 kernel: [  688.475691] RDX: 0000000000000000 
>> RSI: ffffffff9fb712d9 RDI: 00000000ffffffff
>> May 11 10:25:16 NETSYS26 kernel: [  688.478564] RBP: ffffb2674c8afc20 
>> R08: 0000000000000000 R09: 000000000006ba18
>> May 11 10:25:16 NETSYS26 kernel: [  688.481409] R10: 00007fe5a0000000 
>> R11: ffffb2674c8af918 R12: ffff91c66d6f5800
>> May 11 10:25:16 NETSYS26 kernel: [  688.484254] R13: ffff91c66d6f5938 
>> R14: ffff91e5c71ac820 R15: ffff91e5c71ac810
>> May 11 10:25:16 NETSYS26 kernel: [  688.487184] FS: 
>>  00007fe62124a700(0000) GS:ffff92053fd00000(0000) knlGS:0000000000000000
>> May 11 10:25:16 NETSYS26 kernel: [  688.490308] CS:  0010 DS: 0000 
>> ES: 0000 CR0: 0000000080050033
>> May 11 10:25:16 NETSYS26 kernel: [  688.493122] CR2: 000000020000006e 
>> CR3: 0000002095284004 CR4: 00000000001706e0
>> May 11 10:25:16 NETSYS26 kernel: [  688.496142] Call Trace:
>> May 11 10:25:16 NETSYS26 kernel: [  688.499199]  <TASK>
>> May 11 10:25:16 NETSYS26 kernel: [  688.502261] 
>>  kfd_process_evict_queues+0x43/0xf0 [amdgpu]
>> May 11 10:25:16 NETSYS26 kernel: [  688.506378] 
>>  kgd2kfd_quiesce_mm+0x2a/0x60 [amdgpu]
>> May 11 10:25:16 NETSYS26 kernel: [  688.510539] 
>>  amdgpu_amdkfd_evict_userptr+0x46/0x80 [amdgpu]
>> May 11 10:25:16 NETSYS26 kernel: [  688.514110] 
>>  amdgpu_mn_invalidate_hsa+0x9c/0xb0 [amdgpu]
>> May 11 10:25:16 NETSYS26 kernel: [  688.518247] 
>>  __mmu_notifier_invalidate_range_start+0x136/0x1e0
>> May 11 10:25:16 NETSYS26 kernel: [  688.521252] 
>>  change_protection+0x41d/0xcd0
>> May 11 10:25:16 NETSYS26 kernel: [  688.524310] 
>>  change_prot_numa+0x19/0x30
>> May 11 10:25:16 NETSYS26 kernel: [  688.527366] 
>>  task_numa_work+0x1ca/0x330
>> May 11 10:25:16 NETSYS26 kernel: [  688.530157]  task_work_run+0x6c/0xa0
>> May 11 10:25:16 NETSYS26 kernel: [  688.533124] 
>>  exit_to_user_mode_prepare+0x1af/0x1c0
>> May 11 10:25:16 NETSYS26 kernel: [  688.536058] 
>>  syscall_exit_to_user_mode+0x2a/0x40
>> May 11 10:25:16 NETSYS26 kernel: [  688.538989]  do_syscall_64+0x46/0xb0
>> May 11 10:25:16 NETSYS26 kernel: [  688.541830] 
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> May 11 10:25:16 NETSYS26 kernel: [  688.544701] RIP: 0033:0x7fe6585ec317
>> May 11 10:25:16 NETSYS26 kernel: [  688.547297] Code: b3 66 90 48 8b 
>> 05 71 4b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 
>> 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 
>> c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
>> May 11 10:25:16 NETSYS26 kernel: [  688.553183] RSP: 
>> 002b:00007fe6212494c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> May 11 10:25:16 NETSYS26 kernel: [  688.556105] RAX: ffffffffffffffc2 
>> RBX: 0000000000000000 RCX: 00007fe6585ec317
>> May 11 10:25:16 NETSYS26 kernel: [  688.558970] RDX: 00007fe621249540 
>> RSI: 00000000c0584b02 RDI: 0000000000000003
>> May 11 10:25:16 NETSYS26 kernel: [  688.561950] RBP: 00007fe621249540 
>> R08: 0000000000000000 R09: 0000000000040000
>> May 11 10:25:16 NETSYS26 kernel: [  688.564563] R10: 00007fe617480000 
>> R11: 0000000000000246 R12: 00000000c0584b02
>> May 11 10:25:16 NETSYS26 kernel: [  688.567494] R13: 0000000000000003 
>> R14: 0000000000000064 R15: 00007fe621249920
>> May 11 10:25:16 NETSYS26 kernel: [  688.570470]  </TASK>
>> May 11 10:25:16 NETSYS26 kernel: [  688.573380] Modules linked in: 
>> amdgpu(OE) veth nf_conntrack_netlink nfnetlink xfrm_user xt_addrtype 
>> br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat 
>> nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
>> ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter 
>> ebtables ip6table_filter ip6_tables iptable_filter overlay 
>> esp6_offload esp6 esp4_offload esp4 xfrm_algo intel_rapl_msr 
>> intel_rapl_common sb_edac snd_hda_codec_hdmi x86_pkg_temp_thermal 
>> snd_hda_intel intel_powerclamp snd_intel_dspcfg ipmi_ssif coretemp 
>> snd_hda_codec kvm_intel snd_hda_core snd_hwdep kvm snd_pcm snd_timer 
>> snd soundcore ftdi_sio irqbypass rapl intel_cstate usbserial joydev 
>> mei_me input_leds mei iTCO_wdt iTCO_vendor_support lpc_ich ipmi_si 
>> ipmi_devintf mac_hid acpi_power_meter ipmi_msghandler sch_fq_codel 
>> ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi 
>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic 
>> zstd_compress raid10 raid456
>> May 11 10:25:16 NETSYS26 kernel: [  688.573543]  async_raid6_recov 
>> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 
>> raid0 multipath linear iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm 
>> drm_shmem_helper drm_kms_helper syscopyarea hid_generic 
>> crct10dif_pclmul crc32_pclmul sysfillrect ghash_clmulni_intel 
>> sysimgblt fb_sys_fops uas usbhid aesni_intel crypto_simd igb ahci hid 
>> drm usb_storage cryptd libahci dca megaraid_sas i2c_algo_bit wmi 
>> [last unloaded: amdgpu]
>> May 11 10:25:16 NETSYS26 kernel: [  688.611083] CR2: 000000020000006e
>> May 11 10:25:16 NETSYS26 kernel: [  688.614454] ---[ end trace 
>> 349cf28efb6268bc ]—
>>
>> Looking forward to the comments.
>>
>> Regards,
>> Shuotao
>>
>>>
>>> Regards,
>>> Felix
>>>
>>>
>>>> }
>>>>
>>>> Regards,
>>>> Shuotao
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Shuotao
>>>>>>
>>>>>> [  +0.001645] BUG: unable to handle page fault for address:
>>>>>> 0000000000058a68
>>>>>> [  +0.001298] #PF: supervisor read access in kernel mode
>>>>>> [  +0.001252] #PF: error_code(0x0000) - not-present page
>>>>>> [  +0.001248] PGD 8000000115806067 P4D 8000000115806067 PUD
>>>>>> 109b2d067 PMD 0
>>>>>> [  +0.001270] Oops: 0000 [#1] PREEMPT SMP PTI
>>>>>> [  +0.001256] CPU: 5 PID: 13818 Comm: tf_cnn_benchmar Tainted: G
>>>>>>   W   E     5.16.0+ #3
>>>>>> [  +0.001290] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS
>>>>>> 1.5.4 [FPGA Test BIOS] 10/002/2015
>>>>>> [  +0.001309] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>>>>> [  +0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f
>>>>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0
>>>>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c
>>>>>> 2e ca 85
>>>>>> [  +0.002751] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>>>>> [  +0.001388] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX:
>>>>>> 00000000ffffffff
>>>>>> [  +0.001402] RDX: 0000000000000000 RSI: 000000000001629a RDI:
>>>>>> ffff8b0c9c840000
>>>>>> [  +0.001418] RBP: ffffb58fac313948 R08: 0000000000000021 R09:
>>>>>> 0000000000000001
>>>>>> [  +0.001421] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12:
>>>>>> 0000000000058a68
>>>>>> [  +0.001400] R13: 000000000001629a R14: 0000000000000000 R15:
>>>>>> 000000000001629a
>>>>>> [  +0.001397] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [  +0.001411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [  +0.001405] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4:
>>>>>> 00000000001706e0
>>>>>> [  +0.001422] Call Trace:
>>>>>> [  +0.001407]  <TASK>
>>>>>> [  +0.001391]  amdgpu_device_rreg+0x17/0x20 [amdgpu]
>>>>>> [  +0.001614]  amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
>>>>>> [  +0.001735]  phm_wait_for_register_unequal.part.1+0x58/0x90 
>>>>>> [amdgpu]
>>>>>> [  +0.001790]  phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]
>>>>>> [  +0.001800]  vega20_wait_for_response+0x28/0x80 [amdgpu]
>>>>>> [  +0.001757]  vega20_send_msg_to_smc_with_parameter+0x21/0x110 
>>>>>> [amdgpu]
>>>>>> [  +0.001838]  smum_send_msg_to_smc_with_parameter+0xcd/0x100 
>>>>>> [amdgpu]
>>>>>> [  +0.001829]  ? kvfree+0x1e/0x30
>>>>>> [  +0.001462]  vega20_set_power_profile_mode+0x58/0x330 [amdgpu]
>>>>>> [  +0.001868]  ? kvfree+0x1e/0x30
>>>>>> [  +0.001462]  ? ttm_bo_release+0x261/0x370 [ttm]
>>>>>> [  +0.001467]  pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]
>>>>>> [  +0.001863]  amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]
>>>>>> [  +0.001866]  amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]
>>>>>> [  +0.001784]  kfd_dec_compute_active+0x2c/0x50 [amdgpu]
>>>>>> [  +0.001744]  process_termination_cpsch+0x2f9/0x3a0 [amdgpu]
>>>>>> [  +0.001728]  kfd_process_dequeue_from_all_devices+0x49/0x70 
>>>>>> [amdgpu]
>>>>>> [  +0.001730]  kfd_process_notifier_release+0x91/0xe0 [amdgpu]
>>>>>> [  +0.001718]  __mmu_notifier_release+0x77/0x1f0
>>>>>> [  +0.001411]  exit_mmap+0x1b5/0x200
>>>>>> [  +0.001396]  ? __switch_to+0x12d/0x3e0
>>>>>> [  +0.001388]  ? __switch_to_asm+0x36/0x70
>>>>>> [  +0.001372]  ? preempt_count_add+0x74/0xc0
>>>>>> [  +0.001364]  mmput+0x57/0x110
>>>>>> [  +0.001349]  do_exit+0x33d/0xc20
>>>>>> [  +0.001337]  ? _raw_spin_unlock+0x1a/0x30
>>>>>> [  +0.001346]  do_group_exit+0x43/0xa0
>>>>>> [  +0.001341]  get_signal+0x131/0x920
>>>>>> [  +0.001295]  arch_do_signal_or_restart+0xb1/0x870
>>>>>> [  +0.001303]  ? do_futex+0x125/0x190
>>>>>> [  +0.001285]  exit_to_user_mode_prepare+0xb1/0x1c0
>>>>>> [  +0.001282]  syscall_exit_to_user_mode+0x2a/0x40
>>>>>> [  +0.001264]  do_syscall_64+0x46/0xb0
>>>>>> [  +0.001236]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>> [  +0.001219] RIP: 0033:0x7f6aff1d2ad3
>>>>>> [  +0.001177] Code: Unable to access opcode bytes at RIP 
>>>>>> 0x7f6aff1d2aa9.
>>>>>> [  +0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS: 00000246 ORIG_RAX:
>>>>>> 00000000000000ca
>>>>>> [  +0.001170] RAX: fffffffffffffe00 RBX: 0000000004f542b0 RCX:
>>>>>> 00007f6aff1d2ad3
>>>>>> [  +0.001168] RDX: 0000000000000000 RSI: 0000000000000080 RDI:
>>>>>> 0000000004f542d8
>>>>>> [  +0.001162] RBP: 0000000004f542d4 R08: 0000000000000000 R09:
>>>>>> 0000000000000000
>>>>>> [  +0.001152] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>>>> 0000000004f542d8
>>>>>> [  +0.001176] R13: 0000000000000000 R14: 0000000004f54288 R15:
>>>>>> 0000000000000000
>>>>>> [  +0.001152]  </TASK>
>>>>>> [  +0.001113] Modules linked in: veth amdgpu(E) nf_conntrack_netlink
>>>>>> nfnetlink xfrm_user xt_addrtype br_netfilter xt_CHECKSUM
>>>>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
>>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4
>>>>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
>>>>>> ip6_tables iptable_filter overlay esp6_offload esp6 esp4_offload
>>>>>> esp4 xfrm_algo intel_rapl_msr intel_rapl_common sb_edac
>>>>>> x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi
>>>>>> snd_hda_intel ipmi_ssif snd_intel_dspcfg coretemp snd_hda_codec
>>>>>> kvm_intel snd_hda_core snd_hwdep snd_pcm snd_timer snd kvm soundcore
>>>>>> irqbypass ftdi_sio usbserial input_leds iTCO_wdt iTCO_vendor_support
>>>>>> joydev mei_me rapl lpc_ich intel_cstate mei ipmi_si ipmi_devintf
>>>>>> ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel ib_iser
>>>>>> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
>>>>>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs
>>>>>> blake2b_generic zstd_compress raid10 raid456
>>>>>> [  +0.000102]  async_raid6_recov async_memcpy async_pq async_xor
>>>>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
>>>>>> iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper
>>>>>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
>>>>>> crct10dif_pclmul hid_generic crc32_pclmul ghash_clmulni_intel usbhid
>>>>>> uas aesni_intel crypto_simd igb ahci hid drm usb_storage cryptd
>>>>>> libahci dca megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]
>>>>>> [  +0.016626] CR2: 0000000000058a68
>>>>>> [  +0.001550] ---[ end trace ff90849fe0a8b3b4 ]---
>>>>>> [  +0.024953] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>>>>> [  +0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f
>>>>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0
>>>>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c
>>>>>> 2e ca 85
>>>>>> [  +0.003255] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>>>>> [  +0.001641] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX:
>>>>>> 00000000ffffffff
>>>>>> [  +0.001656] RDX: 0000000000000000 RSI: 000000000001629a RDI:
>>>>>> ffff8b0c9c840000
>>>>>> [  +0.001681] RBP: ffffb58fac313948 R08: 0000000000000021 R09:
>>>>>> 0000000000000001
>>>>>> [  +0.001662] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12:
>>>>>> 0000000000058a68
>>>>>> [  +0.001650] R13: 000000000001629a R14: 0000000000000000 R15:
>>>>>> 000000000001629a
>>>>>> [  +0.001648] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [  +0.001668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [  +0.001673] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4:
>>>>>> 00000000001706e0
>>>>>> [  +0.001740] Fixing recursive fault but reboot is needed!
>>>>>>
>>>>>>
>>>>>>> On Apr 21, 2022, at 2:41 AM, Andrey Grodzovsky
>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>
>>>>>>> I retested hot plug tests at the commit I mentioned bellow - looks
>>>>>>> ok, my ASIC is Navi 10, I also tested using Vega 10 and older
>>>>>>> Polaris ASICs (whatever i had at home at the time). It's possible
>>>>>>> there are extra issues in ASICs like ur which I didn't cover during
>>>>>>> tests.
>>>>>>>
>>>>>>> andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test 
>>>>>>> -s 13
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>>
>>>>>>>
>>>>>>> The ASIC NOT support UVD, suite disabled
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>>
>>>>>>>
>>>>>>> The ASIC NOT support VCE, suite disabled
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>>
>>>>>>>
>>>>>>> The ASIC NOT support UVD ENC, suite disabled.
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>>
>>>>>>>
>>>>>>> Don't support TMZ (trust memory zone), security suite disabled
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>>>> Peer device is not opened or has ASIC not supported by the suite,
>>>>>>> skip all Peer to Peer tests.
>>>>>>>
>>>>>>>
>>>>>>> CUnit - A unit testing framework for C - Version 2.1-3
>>>>>>> http://cunit.sourceforge.net/
>>>>>>>
>>>>>>>
>>>>>>> *Suite: Hotunplug Tests**
>>>>>>> ** Test: Unplug card and rescan the bus to plug it back
>>>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>>>>> **passed**
>>>>>>> ** Test: Same as first test but with command submission
>>>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>>>>> **passed**
>>>>>>> ** Test: Unplug with exported bo
>>>>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>>>>> **passed*
>>>>>>>
>>>>>>> Run Summary: Type Total Ran Passed Failed Inactive
>>>>>>> suites 14 1 n/a 0 0
>>>>>>> tests 71 3 3 0 1
>>>>>>> asserts 21 21 21 0 n/a
>>>>>>>
>>>>>>> Elapsed time = 9.195 seconds
>>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>> On 2022-04-20 11:44, Andrey Grodzovsky wrote:
>>>>>>>>
>>>>>>>> The only one in Radeon 7 I see is the same sysfs crash we already
>>>>>>>> fixed so you can use the same fix. The MI 200 issue i haven't seen
>>>>>>>> yet but I also haven't tested MI200 so never saw it before. Need
>>>>>>>> to test when i get the time.
>>>>>>>>
>>>>>>>> So try that fix with Radeon 7 again to see if you pass the tests
>>>>>>>> (the warnings should all be minor issues).
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2022-04-20 05:24, Shuotao Xu wrote:
>>>>>>>>>>
>>>>>>>>>> That a problem, latest working baseline I tested and confirmed
>>>>>>>>>> passing hotplug tests is this branch and
>>>>>>>>>> commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which>
>>>>>>>>>> is amd-staging-drm-next. 5.14 was the branch we ups-reamed the
>>>>>>>>>> hotplug code but it had a lot of regressions over time due to
>>>>>>>>>> new changes (that why I added the hotplug test to try and catch
>>>>>>>>>> them early). It would be best to run this branch on mi-100 so we
>>>>>>>>>> have a clean baseline and only after confirming this particular
>>>>>>>>>> branch from this commits passes libdrm tests only then start
>>>>>>>>>> adding the KFD specific addons. Another option if you can't work
>>>>>>>>>> with MI-100 and this branch is to try a different ASIC that does
>>>>>>>>>> work with this branch (if possible).
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>>>>>> class=>
>>>>>>>>> OK I tried both this commit and the HEAD of and-staging-drm-next
>>>>>>>>> on two GPUs( MI100 and Radeon VII) both did not pass hotplugout
>>>>>>>>> libdrm test. I might be able to gain access to MI200, but I
>>>>>>>>> suspect it would work.
>>>>>>>>>
>>>>>>>>> I copied the complete dmesgs as follows. I highlighted the OOPSES
>>>>>>>>> for you.
>>>>>>>>>
>>>>>>>>> Radeon VII: 
>>>>>>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>>>>> class=>
>>>>>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>>>> class=>
>>>>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>>> class=>
>>>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>> class=>
>>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>> class=>
>>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>> class=>
>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>> class=>
>>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>> class=>
>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>> class=>
>>
>> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>> class=>
> <commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
> class=>
