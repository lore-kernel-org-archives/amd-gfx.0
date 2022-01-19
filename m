Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DA9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 00:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711FD10F02A;
	Wed, 19 Jan 2022 00:16:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBD710F042
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 00:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6IltQzZvPZhkJqXw1pGLNstOXpBfRhgiovcu4HZvoweNB9RpliCUipnBq6zo/enm6cTJJ4zuFNS8zdZt2FYDH8Cs5Gl/9I1GqOytcrRcVTGF8RRoUTKC8Oxq0K9iXqp7e6v6O41zwCW2kxv688nVScieEOrtdmtoALAqKsn0Ow4C6APCGsLwqYF2KmophLWBvisRA+Vr9uGgJekIKSgo8/5AcNZuCuOOQHB2tvI85sBYJorkRbJVKNl/u2X6/vfLpLeeaXKAefRZnlS4T1qlCnRccdJtCso4DCV9bUyyGBf3c5QYHvfPbKowPPcou8/FcmgKlzVt65QL15pyLnAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U4iO1Rb6ce1/8mymVknXhKsdxLirumkB1NxLBUta78=;
 b=V4TZNaRwHfBnGaXInUIMj+nF6q3EdZlmhf82NZ3w8wTwNxpp4DaCrv8u/MlgV1gsnYOdv76wwyDFJ1+TXOQgIRCG8QKORNQ9eab2emEHlJlX5wKb2QLbahbbgkutubUHNsEaeBxp7F872SUAyD/bMCLuC9qoWG4GtP+88CmTh9aGq+VM/3SasDhv08zXYjS2yiikU7UeIWyreQzbcttH2IjVwfLsQH1aYbTp+twgApsqF0um4/wj89efkm5Z/ipziAZL9qDojBB/sILQ90gUvUG7RGiVP01QrT9mIuo5FmjKU1zWDO46EkEBaB+/4QjKoJDr4uFGcGfchuLp6uk4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U4iO1Rb6ce1/8mymVknXhKsdxLirumkB1NxLBUta78=;
 b=poDWDtUFgizYrFVrB3D4xHuiqwXxD5ZD7612Sn5J/2aFe8chKzckUCNYJZ2V2Y6A5wmmVmDBrnwHTy5azRloWBrGAlCrkqiRBsEdyFZ/MYkZzeiUneq+1vBb3LW0kHAvhaTtj6uZYwrFgMchBgbeIcMQHtaxWk2qVj8iCZ6uk9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 00:16:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 00:16:08 +0000
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118224513.26563-1-jinhuieric.huang@amd.com>
 <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
 <DM5PR12MB1308928E28F9CAAB947F9E3585599@DM5PR12MB1308.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <40522d1a-d759-c6c2-96e2-59923573d0ca@amd.com>
Date: Tue, 18 Jan 2022 19:16:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB1308928E28F9CAAB947F9E3585599@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cadcc45-38fb-4aab-aaba-08d9dae0e3e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11459F58BC8914D5845DA48092599@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miXOBILg895ew05nEFFMmCf78V++FDDUyGrtalWV0meK8BgAAuwv0m/1S8zJkpHtqfm3AiZxQWWzA0oGGPTJHWPA+2FJT45zvFIZR7nj4wli1w8G7JjzDGd0bPP3/hEGBViLNZneh+5HpqWHkFKt/10cjBbyzpAcJT5hShfcIRWouKIXQid1+oQKBsIM3zqiXaiwEaJeq/EleDs/q3CqI/a88wczlC/mW7CETPmQ+FyB1EkPygNd56UcvjthV21bKKTFtpT68OoLk0L51/2hJWMlcWPdFpwwIDz5pUoqsPQNzYz71PdcHR+moGRwO8iDrFUo8m1MHXY6PGWQ9SdX2sBwhzKDnhb6Cyv3bwmMdbn/zCbEdr7znJB5nbJn4SB694F69z7fK2f5uPLjem5ciR4SnTXvKW5sx1lu8MytdvCOorVSgfq7JhOOydqEPpHW++DD1Iazq2aTNxMqvEl0u4MXNJNTtkkS3zGs4YBjGeNHGjPtZ1OwnDRKvgminR/ctPYwhyDWoVCgQpgt6mQIa88GtJLyCPTe6VERG45R8HOxkHR0gq8jpzvszhYDnz+gWOZk9jX5LAQ1OssGWgrMnbYalPvzUx7IN2B7cSXiVjvHG/KyZEH3i/P5lKwmS8C2mM22J3vzhi19BJRTUYeog0wLwZIwYwF0cfeLnY5g8GT+9UAxYka69wRedDlk7pQcD2rL+B6Yq1JKg5q0alIjXG+UxsIqMH4184CgWhD8htxifprFpn+OaDsi8ATWXTEha0irc30uJ+GRYLdShRFmhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(6486002)(66476007)(6506007)(8676002)(26005)(36756003)(5660300002)(186003)(86362001)(40140700001)(66946007)(44832011)(38100700002)(508600001)(8936002)(31696002)(110136005)(31686004)(6512007)(83380400001)(66556008)(2616005)(2906002)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFArL3poa3Vham8xcVg2YnNraWM1TVdiM2Z3alVXSTBiem5Qd2hQazdkK1gv?=
 =?utf-8?B?c0NxanlVRXU4Ump2NENPb203TzcyY3BwcXpaZmtBb0tFSlBWdWY5S0pBbDBR?=
 =?utf-8?B?bzdNRUhxSGl5NStpeWhsbkdBZEdoaXcraXNrN09YNDhlZVdSWHVPQXNpT21l?=
 =?utf-8?B?N2JDcnhwRGZFYlVQMnlLaTFHckY1MGtjZW9lR0pZV3VlblVPTTQvTERyYkV4?=
 =?utf-8?B?Q0VZbXJ6R0pDRGtjaG9LOXRsblhoOGtLeFhMUU05cHl0NDI0KzZ3dDVONGVF?=
 =?utf-8?B?TUNxdkJEOEJLWE9GUmZxQVRXWU52d1k4ckd5Q2ltODVESTRVMW03WktIVXdl?=
 =?utf-8?B?R2tnelE4VENuL2VUME8xZFlMNWVTblJscENlTElmMTRzMUEvekxzNjROY1JE?=
 =?utf-8?B?ZkFaZ0FObTBEMm1LSDd3ZjRMUjFQM05qNnc3UTArMmhmeFBPZ2xiak1lSW5a?=
 =?utf-8?B?OURFTlBQSkJvaG5NaEZtMDVuS29hdGt2ZkROd0JYQ2Q2YlFtaU1jVE9yZWtF?=
 =?utf-8?B?TytSdDlsNXVOM3ZkMnJHd3dENnd4ODM5MXZTb3E2RW8vbWRITlA3ekxHdU1w?=
 =?utf-8?B?dWtTUnhWOU5VL0pjNW9pNGRRLy82RThFODhHT1JwVGJ4Uk9FNy9NSlBoaXhC?=
 =?utf-8?B?YjlyWU9RZkVOMnJtWEh6NGtJYkY0cW1VTEFUUTZ3UU0wU29hbmVVWDE0VHY3?=
 =?utf-8?B?enFmVm1DZklhSzdXMThvMEtIK05pUmpIMzdUWEMwMnhuay9NaHhQZGVIRzBZ?=
 =?utf-8?B?SmtHSk4xMnFjclQyRnhQZmFJYXdIVEZLeUlkcnhVejBVVklVanFLN1ljd1V1?=
 =?utf-8?B?bDU2OWplb2RLUm4vd25YelFRTlZ2Umt2YnJlM2syeE43OGtHckEzcytjZHAv?=
 =?utf-8?B?ZjgzNjJpMTM5Mi9vbldaVHM2OGpiRGJFUmJNZld4UE5TMVdWNkROYXcyU1ZI?=
 =?utf-8?B?SWwxQnJOb0xnY1QvMVF1RHhXcXJ3bGlNL255RHlsWGlYMWFmZXV2OWR2M1Ez?=
 =?utf-8?B?YW41d2lOY1VmSHRDYWFrMWE2V1ZtTXVmdlYvbTJsazdseSt3N3p3aXN6TkpT?=
 =?utf-8?B?aE1EOHg0STNWSDg2bDV2TjErUnR0eTBHSWJQK0dtZFpOeGtLM0lJalNJNGty?=
 =?utf-8?B?eVk3dXdHTWVZeTVsK0NnU2dzNFZMcGY0OGt2NUhGaldnbWZ6bTdCWnpWWmpr?=
 =?utf-8?B?NEtyUk5CK2YyUjlOZFltMVhaWkdvaW1hdHBRNFNtSDBncmdJdHAzUTZOTFNI?=
 =?utf-8?B?NXNkYllLK0hCalkrS2huNDZxc29zK1c3bElDV1NVdUdCeEJqRVI0S3I3Mnlk?=
 =?utf-8?B?cDFidldEeEJNY3lnWkVqeDR1YlJzNktwdkttanV6YVRtNUlLcG9uOW1ZQmFu?=
 =?utf-8?B?MkwvbitxNGV3dUg0K1dvQUVQMFB5YjlSbXNzRnhQbEFPRkdtMC9ma2o0K2d5?=
 =?utf-8?B?Y2FsbUlpaC9zSGZaWllTNm0zSWVpa0d3VHd1TGlvTjZkZEpqUG05VFFZY1Na?=
 =?utf-8?B?UGVKMzdaUU0xdEJsa0pkU0xIQ2xYcld5aXlJS25iR3U2L2tzQ1FlejJrZE54?=
 =?utf-8?B?MHYvelJFTzVaa2daM29XS0F0RjVCaDBIemNQbThUWHVwSS8ydmQxZHJFTjVQ?=
 =?utf-8?B?RGwrQ0gyT3V3VmpXVnFsSDdMZ1JLZngzZkZEdUlYbnlnSmFWbktjaFNwOXNK?=
 =?utf-8?B?SmZPV0R6anQzMGxyVkI0YnVKS2E2cTBtQ2U5Z1d2NXo3dlZERWVDRUthblQr?=
 =?utf-8?B?djNsdnh3VlVpL01MWE85K1o3RkxXbDdVOHlGbk1OOHN2bHY3Zm5WSUp1eEFQ?=
 =?utf-8?B?aEZQTzlPZ2thbzJYNEs4OWhubWd3R3VIem1vV3gyV0htR0V1WEszbTdYcUYy?=
 =?utf-8?B?TFArWGhmVTBTTmY3aWgxcmwrbTlabUp3bXM0b3FkTUYzbXlhRGFJcHoxVnp3?=
 =?utf-8?B?K0d3S1dlaUlNWWRFN09YMVlOQ0xya01ZditiUHRvU1dTUXBzczUwOE1WZlRM?=
 =?utf-8?B?RkFPYkRPTGNRZldVbTBnOXBhM01Rc3FPRWRQVFJJTUk1NllVSW4vbkNxZ3Yr?=
 =?utf-8?B?dkY1a1V2czV4ZE1KNVRjajN0U211d2V1QStGNkVNMUF3aEJ3NFNWQy9KSVJ0?=
 =?utf-8?B?YU5BK2RSSEZaUEhybEFrU1NpbCtIRVc5TktPeU1aTmI0RWsvU1BMVWg2QnJT?=
 =?utf-8?Q?3Ser1hV77hRNkZZzTbRckXA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cadcc45-38fb-4aab-aaba-08d9dae0e3e1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:16:08.2257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/lpm87ui9Vm6pSrljrYsbQ7lMgugRRvGMP/P4eena3lQthbDjxfXv4Lbx0Vipap0prtrw2LRrZQot1mcRl3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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

Am 2022-01-18 um 7:08 p.m. schrieb Russell, Kent:
> One question inline
>
>
> *KENT RUSSELL***  
>
> Sr. Software Engineer | Linux Compute Kernel
>
> 1 Commerce Valley Drive East
>
> Markham, ON L3T 7X6
>
> *O*+(1) 289-695-2122**| Ext 72122
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Felix Kuehling <felix.kuehling@amd.com>
> *Sent:* Tuesday, January 18, 2022 6:36 PM
> *To:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>;
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on
> Arcturus
>  
> Am 2022-01-18 um 5:45 p.m. schrieb Eric Huang:
> > SDMA FW fixes the hang issue for adding heavy-weight TLB
> > flush on Arcturus, so we can enable it.
> >
> > Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 ------
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 10 ++++++++--
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index a64cbbd943ba..acb4fd973e60 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1892,12 +1892,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
> >                                true);
> >        ret = unreserve_bo_and_vms(&ctx, false, false);
> > 
> > -     /* Only apply no TLB flush on Aldebaran to
> > -      * workaround regressions on other Asics.
> > -      */
> > -     if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> > -             *table_freed = true;
> > -
> >        goto out;
> > 
> >  out_unreserve:
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index b570c0454ce9..485d4c52c7de 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1596,6 +1596,12 @@ static int
> kfd_ioctl_free_memory_of_gpu(struct file *filep,
> >        return ret;
> >  }
> > 
> > +static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
> > +     return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)
>
> Do we need to add a check for sdma ver >=8 here?

What's the significance of version 8 for Aldebaran? This code was
working on Aldebaran without a version check before. Did we ever
publicly release an SDMA firmware older than version 8 that for Aldebaran?

Regards,
  Felix


>  
> ||
> > +            (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > +             dev->adev->sdma.instance[0].fw_version >= 18);
> > +}
> > +
> >  static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> >                                        struct kfd_process *p, void
> *data)
> >  {
> > @@ -1692,7 +1698,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct
> file *filep,
> >        }
> > 
> >        /* Flush TLBs after waiting for the page table updates to
> complete */
> > -     if (table_freed) {
> > +     if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
> >                for (i = 0; i < args->n_devices; i++) {
> >                        peer = kfd_device_by_id(devices_arr[i]);
> >                        if (WARN_ON_ONCE(!peer))
> > @@ -1806,7 +1812,7 @@ static int
> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
> >        }
> >        mutex_unlock(&p->mutex);
> > 
> > -     if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> > +     if (kfd_flush_tlb_after_unmap(dev)) {
> >                err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
> >                                (struct kgd_mem *) mem, true);
> >                if (err) {
