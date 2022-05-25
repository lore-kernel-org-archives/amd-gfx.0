Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 09:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE8410E653;
	Wed, 25 May 2022 09:25:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF0D10E653
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 09:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI5FpVM1b177PlaNVT8KZ/5Z7bI+Y31yC2TbOaxQFObfUezhkvlB2tQOj9NZXGjtPEg7rFG4iNCwn6frdDbVnEz0/kuHLW7qChELqHpgqNfzQfjHRVB9ccIN8ARw9xKt8P7ego23HcJMtcIczyi7JlKHlXYoUgHhOFNulj76c7cMalwJ7tfkARDd18eVM4PYJLq07ui8FLU9tHusrA/PG5rnouYfeb87TgqpFSr3n7bd/aac2IJvQxPYXlrpv61X4Ck8hBzL3wbcwQP1QSTGf7eQDwdcqppJu7QZSVrKQX7yonKdy7NEodZtR9shDuUyu79WxRWeld7kq1fZ0Y4WHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXcWMB1aTU3e5YlmXgepq0oigdca4/BLBPuqvSRq0OI=;
 b=jU5uFJVmUW4rCAYWraBFppmm6ZvSiUaa5LQYmB5G5WKcsR57gkiU0Fj5r2vKq3URnpXPzl7lJJahEWO/6YCS90leihdGSiCKhlNExiMaY9LZjH7yp4r0TcNFbf9o3mYDEBZaRYQMm9lYBd7S6Is7l0XWnqz2IkFBXw8j9ajKEk5yK4TYnYJrECW5gg5bUYrshat7Et8PsE2RQTy5TDOIc3A0aPkg87nJiTY1mRpkRTN/HnO3464myNG4pOrrhlyO+QE+fjVEfPJqHLbTXoDWOnPTFlnU6wV4oEVyQZ6RO0zWxdsJIOWZbZDRMb2E9rPKG5+B8qzAUhp851flCqSDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXcWMB1aTU3e5YlmXgepq0oigdca4/BLBPuqvSRq0OI=;
 b=Ac2Ovl12hGmnDkUnhESg8McoK0OPJ6cNlyUDaKQmvWJIIeX0I77zfKdRdBDWLX9yMOmmDmXP+bxlwVVl+Ixv1n6g1FzGK2vw/uXQzqqA6XYZf5k+1nPj4IRDRqBozeJZnQm6E+ZriiR/0Lewt6S7bw+qV1eeCZPV5Po9A/MW6p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 09:25:26 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 09:25:26 +0000
Date: Wed, 25 May 2022 17:25:18 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Message-ID: <Yo31/hZQ7qzs2KyO@lang-desktop>
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
 <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d65862e9-9c38-41b4-e95e-08da3e3080d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3983D3173BFBACCA852F071CFBD69@MN2PR12MB3983.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qW2sKqkuhd7UdW+zx7Xpppw/UmFbD5OrqyIoqqWkL4S4PTIPCUYBb8cjKIfLJe6rqcW02LchbRVaqMoX2zHcGZbLPlbIPjVr6A/ngZ/0QpbHE0X3J/bqMpJ8ARQtDkSqHU3iG5ozxD8yeQEa+IuPWYnjUP7CeQhc/cjB7rEOnpSJbo+YOg3p5an1/i4GJgjAc/OnsDOhPwIOQ12id5Y9YKT2yoyTs2yKjRd5NnwjvgldcMOHD9SshVR/jSoxwxg1G+x7YfWfXKn5s8P1GL4aJYwA7FfSqrnI+/MB7ZKwvIZqOk0PLR96zpjSarDJjEb8rwMSuvFXys/OFCF6vKsRxIFgOHDVpfHaTapc/agRQYMrr+J8gyT3L4j9l2aQr2LtL9ZFjVylVJn+NEKOhb0L/3/6dwDnN+bzleZQOzPACve4qeskkUG7/n17/f9kFwiIZZLZrZOXC2D/jQbBRPDyosPxh7HFaqQdPViRUoDtfTN7yHyZqF/wq16gtB2Z7fLSpaEOGPWquwzwz+4Aqm2q+UAf69lumhxECKfvGjieyMbVBFIN1fw5HMPEHw5bh0N9ow6NkmuIPpsr4TyIqyhPFcF4D7LlK/MiA2DfvCfNbcSw/JyqqqwHGD5n5Rxae1I09gLYH7B6XFX6PIZcuLr3aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(66556008)(66946007)(6506007)(26005)(6512007)(9686003)(4326008)(66476007)(8676002)(15650500001)(33716001)(86362001)(5660300002)(508600001)(8936002)(2906002)(38100700002)(83380400001)(316002)(6486002)(6666004)(66574015)(186003)(6916009)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YeJoumwtSdCtB/2F67LYr8a3ZPES0D4jUIhM1vf6hR0+IY4Ek/6CJ6rHdo?=
 =?iso-8859-1?Q?fxHRZ0bMfRmywPx0ErKDIN1dk1gbhmvvXWvdmWBFJw7flIFSfeo+GmRsTR?=
 =?iso-8859-1?Q?BWU6WQZwEBFNPMJwJgdm3SysHgJ4nEsJmjadnbXQcrbPEL0TgN3YRtiPPC?=
 =?iso-8859-1?Q?iIHH9pKM68voYU94xAcwqR2CByFQ5owpDqJBBFTUjqoy1f1EezNo8nYEQS?=
 =?iso-8859-1?Q?8g5IxYM7wVUIZ+M53Eojux1S/nDgtY/J4wIGgfoZyRueX9X3nRPofYV8Kk?=
 =?iso-8859-1?Q?oltSsrcVpHhUvwpQVDrDfVeOJwJPcSgvUEvLJ8N5b1gqWytoJr5JGh0KcP?=
 =?iso-8859-1?Q?7/RaBNxk0zuhT9ioIU3rS8G6r1bYuN9trFOhTPCSWXsu2HavTHaRMmA3Pe?=
 =?iso-8859-1?Q?gX7hbmsEwVYGtJ6zluXxEhDQhXSpwb28nU3X/CiVy+yDP0HvyCbxCzqs4E?=
 =?iso-8859-1?Q?gHp//Knf5JbbvDr1vuUdrI7ZYibJxRzYwhnvre3yWQhbSPLplbVWgq8zgi?=
 =?iso-8859-1?Q?q7r3r7HSxyd6tdqKCIC7ttqEZvMo2fl4B8gNn6xdp48vrdNvRh/rkAWpxu?=
 =?iso-8859-1?Q?c9QWHZAW63oNLxvxVk1LapWoy2Z5E5EDMoWdhfOfUme/uAp8Syulz6jTCc?=
 =?iso-8859-1?Q?d/MQwgjbvraRbexOJlCoQOkXdNRAgYd6zy6vfyKue+FWO0UtmK1pQl084I?=
 =?iso-8859-1?Q?HZOjwLYZZTc3SkC9wgQudkEhvxyOq4O6z7Lu2UH/MD9oVlNu+H3sH2J42Z?=
 =?iso-8859-1?Q?udorsYC0Tx9F8YdcPBBTI47zo3Nmu+Ts5CNCBb/uh7YilDue/kYU9zmvU6?=
 =?iso-8859-1?Q?meUL8NJimHYVnI1ywInj1zEBF3vZBHqQFQFl+RxGebbRougavtPWBnwyOv?=
 =?iso-8859-1?Q?AT7YjT8W9PD/s15ajxYlBwommDlBCDTTt+8cqlMETZbKDDwBj4Izpvy46Z?=
 =?iso-8859-1?Q?oF1sYh2ZSf0znOMAyEkTZ/D2oY6eTtk/9dbJaArnWMufGHGWJCTbguPYph?=
 =?iso-8859-1?Q?pkxrQaPMwCCJ/+iILzRH99Zd+gz9IFY7KIPkgma3/q1RKmCVihxyCJ3XMh?=
 =?iso-8859-1?Q?NSp0YFRzeJGeTeXyZrhVFk9roWF62J3gLFIEQMUZnaPmeZ8S4IAoEJ6m7w?=
 =?iso-8859-1?Q?PxPOzGVsB38/5kiD5B49JdMgwsM5RxbJPwsJmRLG131to6WmsMr8S/z0uo?=
 =?iso-8859-1?Q?j1Na34Q+EBfE/gp5opUmiJiHCXtpmYhK84/GcC1HPzMjjisH+zf+gc5U/H?=
 =?iso-8859-1?Q?6q4xzHcdSb9P8+zxOR9jfQkIy+97w3q6Cn/gkpFm04REL6dcrziqdt96bD?=
 =?iso-8859-1?Q?sywvQjgQeCYTK1duCwvACF7XpcwipN6yc84k1iT1ryVe8HXwfsxqMJCv3g?=
 =?iso-8859-1?Q?3GJY3gBybP/FnDjW9nU9cUKUld+kslR2joSY0DTNdu8JJkdwAGVfyWn6/h?=
 =?iso-8859-1?Q?vlpMGDKFqf3MzJ/ESgDRSZol/JHebQPmeb7TpeEDhQbadnaBnWayfUWjhS?=
 =?iso-8859-1?Q?BCZNIBcJ51TEeVrrrbx3mrnhg50DYGpoDzUMW8w8dzv/KWwBGrlcaFtdjN?=
 =?iso-8859-1?Q?H6qmeNWfRqRjy3zXRB/0GqSLZxh2K/5BSSGx2LDIzDPGfPGSr0GbDONR2j?=
 =?iso-8859-1?Q?Yq69NmCNpmgy3DU1+zc0K2zLkD9hREEbqZIMW51rt1QQNuwKKMfcnuxAwe?=
 =?iso-8859-1?Q?uBJfjFfHpyA+fzZycpOD01Bt0LkPzv5HVAaUAJ3PefBpaHAC9sEgOxUY9J?=
 =?iso-8859-1?Q?9t56wn5CMtXVFP0FqTdVERiTe/kU+0lfpMYVPWgWRp0+J2YW/9wGsTohF2?=
 =?iso-8859-1?Q?M/rY+EkxEA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65862e9-9c38-41b4-e95e-08da3e3080d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:25:26.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItSXLntZOzSVCsDOjCKJ0+MkHItqgU/yapdvrXhhQmbovp5w95sLzDL0xt3Wv4CaOfNdnvPxVI/AuO3zaqlIwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 05/25/ , Christian König wrote:
> Am 25.05.22 um 10:43 schrieb Lang Yu:
> > DOORBELL and MMIO BOs never move once created.
> > No need to validate them after that.
> 
> Yeah, but you still need to make sure their page tables are up to date.
> 
> So this here might break horrible.

These BOs(and attachments) are validated when allocated and mapped.
Their page tables should be determined at this time. 

The kfd_bo_list is used to restore BOs after evictions.

Do you mean their page tabes could be changed? Thanks. 


> Christian.
> 
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 34ba9e776521..45de9cadd771 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
> >   	struct ttm_validate_buffer *entry = &mem->validate_list;
> >   	struct amdgpu_bo *bo = mem->bo;
> > +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> > +		return;
> > +
> >   	INIT_LIST_HEAD(&entry->head);
> >   	entry->num_shared = 1;
> >   	entry->bo = &bo->tbo;
> > @@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
> >   {
> >   	struct ttm_validate_buffer *bo_list_entry;
> > +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> > +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> > +		return;
> > +
> >   	bo_list_entry = &mem->validate_list;
> >   	mutex_lock(&process_info->lock);
> >   	list_del(&bo_list_entry->head);
> > @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >   	unsigned long bo_size = mem->bo->tbo.base.size;
> >   	struct kfd_mem_attachment *entry, *tmp;
> >   	struct bo_vm_reservation_context ctx;
> > -	struct ttm_validate_buffer *bo_list_entry;
> >   	unsigned int mapped_to_gpu_memory;
> >   	int ret;
> >   	bool is_imported = false;
> > @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >   	}
> >   	/* Make sure restore workers don't access the BO any more */
> > -	bo_list_entry = &mem->validate_list;
> > -	mutex_lock(&process_info->lock);
> > -	list_del(&bo_list_entry->head);
> > -	mutex_unlock(&process_info->lock);
> > +	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
> >   	/* No more MMU notifiers */
> >   	amdgpu_mn_unregister(mem->bo);
> 
