Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 11:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79AF64EEB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 11:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79AF64EEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF9C89E98;
	Wed,  3 Mar 2021 11:12:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DB789E98
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 11:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpz/hs5pca7ZkRi9j9/p1YIBzHTPXBpich4JenSfo/JtI3tXDQDaONPGdI5gfalcNFMM/Pd9d6paT5F0S+QXufKs78sVmK5U6ONTvHD9cp/W5N1xGdQ57oG91M5CPMMb3S8JyOujPh3eDqARtGxnggNWNxezThYIAdWptGh0ccPSZS8nRP5gqop6Wot3eONHu+Ber/NwVFzPA/q4nsjSOSOTSzyN4kkjCB8lZdTTdGkh8O1WGbhkjTkIcY4hRY4/DKn3JULrT9yRb33VdWs1zsp+tFpDbbRrgTEgxiFGb9cSrFIHEDiHNp9GiNTv9W+G6EbHNZXBHvZYPfDHhTSRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NvWPy+Olx9Fw3sGUtG4aPi4VqN10Isdu7OJnyM6ZwA=;
 b=lGtkElhwqPG8uPvNfYwL+w+d2NofYDdiXEiHdf5AUDTQfgxhm+sNqFe1ZNpiEcaLVAXBaO+xBqxUq23Z/IpN/rDfMWN8k5rVEFf1rgV69q/e7eV/9Rrk0QdsT+KuucavXeyljLSqFRM2nipCVfeAo5p+mkZKYmzpQRU+R7Q5EMlkoy9TIzCDQEc1PhWMe0eAy2ZF0s/VDt9VXr/DVBVoG4MzLeCJoPZJf7ndfrTivK5eYdsO5U3kX3WmKaw7CQV7HYxudLFk8lCOxUL+/K7lnjHe0yDCQjvb+X955t1NXVuiP8y7buqtL+wsikIVmJFPjxto/dB7ozwLlsMA5SajZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NvWPy+Olx9Fw3sGUtG4aPi4VqN10Isdu7OJnyM6ZwA=;
 b=wUVvCqPTvhxlOkubcAbvNp1eFO2hPuI/5HfjDtKITbdumIOrDasRHh48bFCvU65dMgjwLHHOX7IHAKi16mZPF+xTob+rwiePfa09NcSBjeQpfXqVnkphe2KNOjzoWmnZKzmDeevhagGfK8f6vca+zay2ZJDXAwgmkW6UixbC8eI=
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 11:12:47 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 11:12:47 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Topic: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Index: AQHXDAkTQPRetpjE1UGTITp0VoVajqpvBkyAgABKdQCAAtDaMA==
Date: Wed, 3 Mar 2021 11:12:47 +0000
Message-ID: <DM6PR12MB2939CA38BE8CAF923240CF34E1989@DM6PR12MB2939.namprd12.prod.outlook.com>
References: <20210226063122.9902-1-horace.chen@amd.com>
 <CY4PR12MB17036381E3A8C93A36AAC8E2849A9@CY4PR12MB1703.namprd12.prod.outlook.com>
 <CADnq5_Nt81TqAbkOoTjtFVGYQhfQzJ=g4XHEkz1W77h7rZBfrA@mail.gmail.com>
In-Reply-To: <CADnq5_Nt81TqAbkOoTjtFVGYQhfQzJ=g4XHEkz1W77h7rZBfrA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a73d4ed8-6164-4241-993c-16a2d35838a8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-03T11:03:27Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de6b6bc8-3b8c-4431-e686-08d8de354698
x-ms-traffictypediagnostic: DM5PR12MB1883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18837D255535E125211E60B5E1989@DM5PR12MB1883.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwTpWU1KXVu8stGBTH68wjRvsXgJsErXvOX6fg6IMMEktqBXsgLpWJrudgYkhCybzYVRsG8iliMZ/1jElHYsYjeHbn8CRMjOBqrBd0+q7yPjTvhd7tizUNsXo73i3b+R0Lthy9dsgbVIrwT7jRtZc9OKoOnNJNhQi8/11KwSdjWwyqRGo3gA7bQQVuS9PXSlq/cXAlEVliMLoNxa+Gbibutgv7QHIzDD++9Yfd8rsN8ebky75jrajO+aSAYNS52zvox/+9axcW5rf+HHoglg8RARaOAgT8jCf5E+73xGeXkQZc1RdGho5KukoJBU5tHBfa+SNtb9UzAQtHsFkkBHb3/dXkev/38S59cp6z6QA/SbGdwP/qta1gsA+b6MxA8RUqzB6+vbqdHRFkHFsEN6b73gAGeyi/e6bg7vShUHfCEEk4DxOTRhNBqsy2N+IPEhPU8RC6LdaSlVjBRO8j3Jg0n1NEQ23PT94Qq7ZmSsCj69e1XT69Zk9aJzmYMx3SHnH7yB8UPFxTppq+aul2rvNY95p0y96qrwg+vyUkv9OCvCJxw8uek6E7tQCgaV79jI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(7696005)(6636002)(26005)(110136005)(8676002)(9686003)(66476007)(33656002)(4326008)(19627235002)(966005)(66446008)(54906003)(64756008)(8936002)(71200400001)(86362001)(186003)(76116006)(55016002)(6506007)(66946007)(478600001)(5660300002)(45080400002)(83380400001)(66556008)(316002)(2906002)(52536014)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Bbm4Mq+7ADmyiLJfjyzoBDs9SvmMbRS6zTJt2tyIzoUfkKUjTVsK2dDE+Dmj?=
 =?us-ascii?Q?45QcE4jfel1qUZCdEY+jtIgHRg2i1qKokjpEPFOXCC0NPz1BTmOoxbyyBQ2L?=
 =?us-ascii?Q?oz0nxiJSrAG1iIgCEVDRUNbMBExQbvDmqxyflApBMVmXQUtepwLzsP6qXOHB?=
 =?us-ascii?Q?Gu1WtqqAnRPQscrMCW2RhW8/9nqwFe3iBig2TRQ6jrRhAGRr2uML6Buu8agK?=
 =?us-ascii?Q?6q5cTMri9S+O1gFqRfXwVIlUBqgNuDss+LbODn2LLA5FF1wcVTdVQAMH09Hk?=
 =?us-ascii?Q?wKAkyWL1f8KoxJ6AvlndQMtshRbgsyoRHN3XGjQATGHNvGRcfCMOy3ehGDV+?=
 =?us-ascii?Q?LfX2lkF7fn8as/wCH3ez/du1ZdZHavlnObrR/0drrtk6sWq6CMxH8dYmLDPg?=
 =?us-ascii?Q?Si5FvFqef5YIEWBLTrXRMvEutOlb60ShnNl3Mz7Kxy9ydD8vggQdWDZMTesS?=
 =?us-ascii?Q?nwaLtVZH8fEHZZV6deDS1RZv7+RDX9bJjsAvnD41IAcjqJ5X80vZCaJ0TZCh?=
 =?us-ascii?Q?GIWaSDfCVbFmYZ+daDD1PY0A399o6noIxX2zvuwMCg45x/Ipte1bS4Dxj+Ql?=
 =?us-ascii?Q?Do0hPfAdjKHR6ChHas4wIh/xe5DMVLwolegBWrwXSrhOB+VRqk4quAFhMMT/?=
 =?us-ascii?Q?n5e0t23ki7lMDqap+LmzaM/1tT0nlLAUDSSbyctwh3G1/HbKr0/LG5utkMm8?=
 =?us-ascii?Q?WcuOdO/F23zrXIf6ZLcmN+tpbK8o8ERPuxgLNuCZLHSY1QhXQrqQd/4jGzA4?=
 =?us-ascii?Q?VKi4FetqkZewc/ojVgAST3sUEAnoWLReIfX4k3cug23OIhMN++Hdc4und5XJ?=
 =?us-ascii?Q?BnOGaOXh/qHe/Y4NySHqzxRIRBVUHLQUJqCOAfIOJIt+8pqoP2WfDfr2V0o/?=
 =?us-ascii?Q?Fu+y/ijHxyy36uNNDOAREtOUgb4T/16bE+EThvqrPaputAjR0wHhyf7GCvj5?=
 =?us-ascii?Q?Wj0K24qAEFKbm7/qhJat75TpzuvnkJ+eCuFX9/urC7TGENkeAyq9TrFcWzTm?=
 =?us-ascii?Q?T4j/lfvbix2G6NSEwmBhvk+foLsSyl8T45RFhASfXiMkb4luFs5dgCB5UpFf?=
 =?us-ascii?Q?J+BhRnYF+REEyT1JFPWXM6Abf3pRCGDIzEWC3s/V/cXAH4hDnZqZvvXSbiyt?=
 =?us-ascii?Q?wZqki0SZMubhVpbLk51qWtASdArpaqoAxtP0ASWV4I20geidmc2iPqYfxLu0?=
 =?us-ascii?Q?TC4nAW2C0t5XZHKfZJXJ17UyAe7bmwaG16+SB+ICrr7n6tVcD4h8Q99L8BSB?=
 =?us-ascii?Q?cYsvL9Rp+N1ARa5lDqgwMXQ6Y2mE+P0iAOVRe6ELQn/eDz63StdgHSaWhUg/?=
 =?us-ascii?Q?lZf/ASAnqec95f6TWHfJd+5G?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6b6bc8-3b8c-4431-e686-08d8de354698
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 11:12:47.0434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DuSCCDxJyqn1v08QSL6bY4/hHO+8/RZdsbF2RLcg7aTkuFsaNh0BhDkIIyjawZs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

Actually I think this can be a potential bug on bare metal, asics may not support overdrive but still need to set default od. If there is an SMU firmware which supports  PPSMC_MSG_TransferTableSmu2Dram but not support overdrive (just like sriov one vf mode), then the bug appears.

But since I don't have bare metal environment, I can let bare metal still run the old code path.

Thanks & Regards,
Horace.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, March 2, 2021 12:03 AM
To: Liu, Monk <Monk.Liu@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf

On Mon, Mar 1, 2021 at 6:37 AM Liu, Monk <Monk.Liu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Pls change "    if (smu->od_enabled) {"             to       " if (amdgpu_sriov_vf() && smu->od_enabled) {"

Won't that break bare metal?

Alex

>
> With this addressed the patch is reviewed by me
>
> Thanks
>
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
>
> -----Original Message-----
> From: Horace Chen <horace.chen@amd.com>
> Sent: Friday, February 26, 2021 2:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
> Subject: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
>
> sienna cichlid needs one vf mode which allows vf to set and get clock status from guest vm. So now expose the required interface and allow some smu request on VF mode. Also since this asic blocked direct MMIO access, use KIQ to send SMU request under sriov vf.
>
> OD use same command as getting pp table which is not allowed for  sienna cichlid, so remove OD feature under sriov vf.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c                   |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 10 ++++++----
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c               | 12 ++++++------
>  5 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f0f7ed42ee7f..dfbf2f2db0de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>         adev->pm.pp_feature = amdgpu_pp_feature_mask;
>         if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
>                 adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +       if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
> +               adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
>
>         for (i = 0; i < adev->num_ip_blocks; i++) {
>                 if ((amdgpu_ip_block_mask & (1 << i)) == 0) { diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index b770dd634ab6..1866cbaf70c3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>
>  static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATTR_FLAG_BASIC),
> +       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            ATTR_FLAG_BASIC),
>         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATTR_FLAG_BASIC),
>         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATTR_FLAG_BASIC),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d143ef1b460b..7033d52eb4d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -612,10 +612,12 @@ static int smu_late_init(void *handle)
>                 return ret;
>         }
>
> -       ret = smu_set_default_od_settings(smu);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to setup default OD settings!\n");
> -               return ret;
> +       if (smu->od_enabled) {
> +               ret = smu_set_default_od_settings(smu);
> +               if (ret) {
> +                       dev_err(adev->dev, "Failed to setup default OD settings!\n");
> +                       return ret;
> +               }
>         }
>
>         ret = smu_populate_umd_state_clk(smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index af73e1430af5..441effc23625 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>         MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
>         MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask,             1),
>         MSG_MAP(SetPptLimit,                    PPSMC_MSG_SetPptLimit,                 0),
> -       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,       0),
> -       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,        0),
> +       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,       1),
> +       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,        1),
>         MSG_MAP(SetToolsDramAddrHigh,           PPSMC_MSG_SetToolsDramAddrHigh,        0),
>         MSG_MAP(SetToolsDramAddrLow,            PPSMC_MSG_SetToolsDramAddrLow,         0),
> -       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,       0),
> +       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,       1),
>         MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,       0),
>         MSG_MAP(UseDefaultPPTable,              PPSMC_MSG_UseDefaultPPTable,           0),
>         MSG_MAP(RunDcBtc,                       PPSMC_MSG_RunDcBtc,                    0),
>         MSG_MAP(EnterBaco,                      PPSMC_MSG_EnterBaco,                   0),
> -       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,            0),
> -       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,            0),
> +       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,            1),
> +       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,            1),
>         MSG_MAP(SetHardMinByFreq,               PPSMC_MSG_SetHardMinByFreq,            1),
>         MSG_MAP(SetHardMaxByFreq,               PPSMC_MSG_SetHardMaxByFreq,            0),
>         MSG_MAP(GetMinDpmFreq,                  PPSMC_MSG_GetMinDpmFreq,               1),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index bcedd4d92e35..d955dc4c6998 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,  {
>         struct amdgpu_device *adev = smu->adev;
>
> -       *arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>  }
>
>  static int smu_cmn_wait_for_response(struct smu_context *smu) @@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
>         uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
>
>         for (i = 0; i < timeout; i++) {
> -               cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +               cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>                 if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>                         return cur_value;
>
> @@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
>         if (i == timeout)
>                 return -ETIME;
>
> -       return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>  }
>
>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu, @@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>                 return ret;
>         }
>
> -       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> -       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> -       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> +       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> +       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> +       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>
>         return 0;
>  }
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CHorace.Chen%40amd.com%7Cddfdb19f0d204d9396f608d8dccb933d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637502114201903228%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=XiMOJG3w57rq2TLsTDh0ItoVpWsjD11buv15dRgKUiM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
