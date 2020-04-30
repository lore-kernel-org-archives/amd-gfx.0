Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174D4C8300A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5AF20873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DEZB1YYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5AF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7203E6E890;
	Thu, 30 Apr 2020 13:11:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770079.outbound.protection.outlook.com [40.107.77.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747D36E890
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 13:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfLdMsYuDBfp07HqUxbNsBoXQwuhntM/AdcplHcTTeptGHZMc5s8fdSt/529vG8v1FCGKW2FDD+mP+3fx01n7TY/iUiedD5roc2YduxkYirtQqjlffhPZCZjPXUUJIr5RZKy+5Y647VHIMlT3jK6IS2hJXqOLRkis2jci578I+cKXmAlx5kq2X1rTajv2L73M9IQ12QvYAOMSUxCWwJODk7XH5lSaFwrlIwZIs+MdSGzcFjm3jcw0cSGuz7DhJJtz5XW3Zk/s2NBlZf9BwVsCROWLVYHbash9PhYX1Qyebox/17lQBfBQ2UzhukUxoFiuw/kDKMrJg/AOuICSHv48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8H7S46Mk9Ddfxd1nSvk0NslazwWsksUdVFdgaGnQoM=;
 b=VYtKSIoFJi4NcCiJ85b/f5dfmagWUIXKT9HeDsr4dEIx75GkAzdLDch6QNkoSTzg+QXXmbVV/m1ZVmNL/913FlldedWvgNhaQCuIx9VTjs3w7jxIjIFP070stvuO5HQNygyMRzfRvymSjjT+FjrjzyQbthnMvdBpHj1gMA2s1eKBzQndVK0RDb92C2UnTUoTf1I7eufozn3qhqo5Z3aR/hIdwwuldxQWdqkTSM8gLTqw9KUPWsAQ2V+ktlaygDy2UCN+KGXqCAvRYa+Xau0MVSAUUP8TcMKTHKImKlWCkzPCk+uTrqAoZG65muD3azgKn9leoBa+sKxqB2pymKhSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8H7S46Mk9Ddfxd1nSvk0NslazwWsksUdVFdgaGnQoM=;
 b=DEZB1YYLh6+7nXklKuYaVij9L/XgtZwAON+Oj2gcew97M+KKQEN60rY9/JZojD9C/LnNuRpUqWd8vcNNRVXqiNXIamFloxK7p0v+FwVcQiEn2fJ0/uUMDjUHtadBVH+Z+n6TQ3JuwB+wGWFwvJJqNFpZQoUpmO6Cbu7KNkooUWg=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3545.namprd12.prod.outlook.com (2603:10b6:5:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 13:11:12 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 13:11:12 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Thread-Index: AQHWHLOVWjB6qGVLjki2kiF3JIbFbqiQ+KAAgACvh7A=
Date: Thu, 30 Apr 2020 13:11:11 +0000
Message-ID: <DM6PR12MB37210B5A97E236D5CF92870885AA0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200427164735.27409-1-kent.russell@amd.com>
 <20200427164735.27409-2-kent.russell@amd.com>
 <DM6PR12MB26198CA4F1E94DD9D8623E2CE4AA0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26198CA4F1E94DD9D8623E2CE4AA0@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f5570c62-8f92-4537-b09e-000085ee6d42;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-30T02:39:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-30T13:11:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 87837f3a-3b53-47d9-88d2-0000d3577b46
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:d812:3a5e:6edb:851f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ee530eb-dbf6-4855-7e23-08d7ed07f49f
x-ms-traffictypediagnostic: DM6PR12MB3545:|DM6PR12MB3545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3545BED100C1ADFE9CA0814685AA0@DM6PR12MB3545.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(86362001)(2906002)(45080400002)(478600001)(6506007)(966005)(71200400001)(7696005)(316002)(53546011)(8676002)(110136005)(52536014)(33656002)(66446008)(66476007)(8936002)(186003)(55016002)(64756008)(9686003)(5660300002)(66946007)(76116006)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3plAK9rPsHYlVoI2XPCl2EWqAm/B0/Mtbu6ta9S7wyG6oSncwWCmkte9ZR28aeJEBBM5rgcbI1v6Qo/LKAsemEuB5MYpjklysOV6h/GPMKjGPgreEltp/dx3kMbcmMTkcr+ubx5gaqNzbkh2WWajtHwahCD1L7zN4uSc5fktnIH6P8wb74dSd021vQWFOki7gIkwBdZO8ju0zSEQAFrdudlLb8nWGNlutBKoJBBdlKOerWsY4da4ybFFFNM0omBpkF2pH+oWM0qvdaiSui7kkaJ4wFmaXDxd6J2HgUSJKSQSapxA4stAea7p/HffQMnRchL4CZC9OlyecOyXeQifsZVUIXbtwiDli5BnA4JFHYVxisyJIvfixpFIWhUnULqKHd+m2Sf6Ehbym1woucJXog7k28c5ELPQB9KDNt5VhOf2CggHdQq/lkwREeoKxM9d2trRR6salh02VfAZjWL1Z9Mi946U3Y2aOpktcNe7n4fEIpcFwPsd4NImh9qEssyYp+a1p90ox7wiNiE9cTqZg==
x-ms-exchange-antispam-messagedata: i3H5/2+tgxoP5wM7GBnArhKJNUtyjE0iQh1gcyvWTzqF2CtXROAkDoX4VPe6hrvrE1io5ZkT2Rorfsh3ft8W6F3g5UD4UYCnvkm2QN9p4/mDwGJ8z0kiMFwid9bSQ3qJeeOlaMfp51FE4Bk4zDtuiAH3Dw1kBR3odI2dHDCQMKFKgwnEK1MfVapquP2kGYGU21/uqdvOz+qynzLQ8FTAszRRxL3S9fhs12PxHf7zzTpW4/FwzR46KTkXssrocvcELIjjOmrhLGA+U2MQdVyhxImcWt6Ez7OzkiTHxtggret16dmkcEqDzxkb7gnfHdO2ykGoEWlkU0vNgdfL1GhncqQ4vwM4GwMaSCI+/r6jOMZdwrMYBv3dVMnKr5lNQJeS+WXFQMNOTR2dhiYe+ialDHd4n9bFE5kxpXBsDi7AhkneeuPJt17oxYBP1+4xnGNpPL0bG8vtRbOz4CFGZUqwbaejIE03F0DkbOMwZb8gXOaJl/Kel7nS+/Mv2027SJZMLJrH6+ti6bt3yAsOtPS2eN2v3KxU6oZ5cMDTZoHHwyE0T/4sG05+fgT6a8MxHUeiU2xtWF16s8feE5yZG/ZWj+7S98ByIXXxD6Nb8UTw0TLyEzD3ELh0GTbksAbcQFwe4FpGsW1YZPVtm1JywQ/fc3/bY8llo1W89ZrIhKrl8MIvF9EeLb/OgkZbaHJqlb2UzzVU7UxOEq6n77wne4XUdNHDOG961YC3uS49f46TIHxgdniqQaGQ7Lo7fFMtUB1BhCOLVYVG4RLUuuOVATvQ1uuH+yICs36J77fkdax6fkX1KttLfXGab1PUl6ktV7l1oD2wT3j/2MV/kG9YqbGEe9G3WXfG46dgICC9GaaQRyNqkHqLoDLu/6A/Xv9nyGXv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee530eb-dbf6-4855-7e23-08d7ed07f49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 13:11:11.9012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfqEQz7EuQpKLp1lWATkCewApHx4xwrZEIiRvOppGDF5JQS9ybZs7ywwz43m2Wlp1A55JNpGlQnY/uzc/nfmfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Good to know. I'll make a new patch to move it down the boot order. Thanks!

 Kent

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Wednesday, April 29, 2020 10:43 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
>
> [AMD Official Use Only - Internal Distribution Only]
>
> arcturus_tables_init() is performed on ip sw_init when the SMU hw may be not
> ready for message handling.
> I would suggest to put this in some API of later SMU hw_init.
>
> Regards,
> Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> Sent: Tuesday, April 28, 2020 12:48 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
>
> Add support for unique_id for Arcturus, since we only have the ppsmc
> definitions for that added at the moment
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Change-Id: I66f8e9ff41521d6c13ff673587d6061c1f3f4b7a
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index e98d92ec1eac..f55f9b371bf2 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -293,6 +293,7 @@ static int arcturus_get_workload_type(struct
> smu_context *smu, enum PP_SMC_POWER  static int
> arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)  {
> struct smu_table_context *smu_table = &smu->smu_table;
> +uint32_t top32, bottom32;
>
>  SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
>         PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM); @@ -315,6 +316,15 @@
> static int arcturus_tables_init(struct smu_context *smu, struct smu_table
> *table  return -ENOMEM;  smu_table->metrics_time = 0;
>
> +if (smu->adev->asic_type == CHIP_ARCTURUS) {
> +/* Get the SN to turn into a Unique ID */ smu_send_smc_msg(smu,
> +SMU_MSG_ReadSerialNumTop32,  &top32); smu_send_smc_msg(smu,
> +SMU_MSG_ReadSerialNumBottom32,  &bottom32);
> +
> +smu->adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
> +}
>  return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ce1f630b561f3402e0a
> bc08d7eacab98c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7236029365851744&amp;sdata=re07oSC474wvdHv7wWJCVYxj842eihH%2Fkr0
> Sz0YoE94%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
