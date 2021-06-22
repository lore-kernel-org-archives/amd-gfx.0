Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03949C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 06:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF2961002
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 06:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF2961002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E7B6E192;
	Tue, 22 Jun 2021 06:08:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037E26E192
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 06:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfk1WrUcu1W7gWNP7Sx9dIdZl+B0ai9KAxIeoIbiH20z3A3Qor8QhjnFdlwcOTfWpmhnf3+8DYRpTaeABXfaZjogQxhFKZ623NKzsRzBPfqxob2UkIf+NwOuz9VvlzR3XjkHQJUEIpvFmoXfZgRAg4mYxmPsx2VLJn+mLbGDKzJS3lm40zktcf0foQofPBrzw9nlFRbZuOP1li8h7cbEe+/d918O4AWzi/SMN4apdE/wVCb7oCCmLEUjrpve3VN3gna5OIt6U1IsAnQD0Ix5R5oP+iZifuZ73U1IiBR5h4nXR2kfKummWEQnm9qW5rxyZmiRf5R+ShMTkhQaIQpqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy7dGxDbTotEr8Tnv0IbCmgXvbjZDli23aAlFJeFlNw=;
 b=JWOSwyjh+d3/sZWdj5MvxkVE8UwpK+UqsZ9EqX4kJINT8hgtIjUX3x1axsBQ3ZkovDizsbAnDr1d72rJE8TdEFtsjUtaDWHfm+ljKeumVcTfTqVJrDMEH+3VdGciKBpdXcrecqlmnrXAkv8VdGpZq7brmel5gOispYNbcAtflVRMKmB5VFREyzUM6HBSfSlUss/WYFKd/+IbVpj1TsaT5IiPTPfyCp3FEMmkyQfYiWOMQhgVNmZQAV6pmL3HbphzN8ap1cUlqBxOTW9J+fZATaTIt1k8VpWD0Dyf+Y/1iC1QjQXm+oQczBPLl8kDCBntxf22hDoSFm1hMLjc1i7V0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy7dGxDbTotEr8Tnv0IbCmgXvbjZDli23aAlFJeFlNw=;
 b=C7gQeVHmacDjPQ74E5U5tVMXrdWQZ/03ouvzAbXTHzANc+eNLmjtY7BJxpJ2a4X1LLcCPQ6TAELeIJsdc4VkwulwA1sc4seqe7SJF3ze/Izn3EYaLpUNzS8EFHSv703dGT5w3grQ62QA91R2KsJNPfnhB/EgJFErk0e9Dxoek+A=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 06:08:12 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 06:08:11 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Thread-Topic: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Thread-Index: AQHXZmsxWYSJtjLU9kmsZQUGxR3V46seX0oAgADvpgCAADwRsA==
Date: Tue, 22 Jun 2021 06:08:11 +0000
Message-ID: <CH0PR12MB5348A92078FAAEB0F132A78D97099@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
 <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
 <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-22T06:08:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=071d4373-c5ca-4cad-9c08-1f86d88eeba4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:9656:387c:82ed:cb97:f272]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb74b5c-8d6c-45cd-454c-08d935441d92
x-ms-traffictypediagnostic: CH0PR12MB5186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5186B68668440637958094B197099@CH0PR12MB5186.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7HUzj0OKtmDwb/9x2J6cGbxtFRnRqGtEZtEOK94Qdxn3CfW7xCDYIy4O3XS/DO0k8xogyYH2eCAl2gssRhvfEaXkfDJJQiZJoM8gvJ5VSDAWdX20jvXZ2s54wKRSQVXp9mscVMs0sHuWoJbh3IjKXNr08xzNS8ie+bTDVNR2FnLOpGtoC+fMZRQ0i8u5CHCMNPrASBUmMDzjNtRJiuKB843U2XSrj/kmiEZyetYcP5U+eWltCeYa4FU/k0cnZ+8GDvG2lvEVC4tTm1iIYPR0rOXfeUzFuMG9Ih6GRfUHkYX1ND+DMghXC4VY4B74UqUd2vAXei1srSFK68SCAsla27mAjepyCnnOL+pkCyZbRXWZehYKJ5Adf7IgSKXpfdEyspff3vxhVikKdppAtVu8Ftjqdd1Q6W3GPca0U8pyAfa5sxfbCAUAX8Mw1EtLlZ8APbkdfHAFNLbyjmHoIq+OBP4qSTlAaLayVLjq51PyWTlwPXvVOtCUM+KBXC1Rerr7e0VrX4HX8VTCjcomqxo1lzM+6aQCdMiiA/yIryE+2kjJVSvBZy/bAePhZalunOrWndRZW7owklBH1o+WVs+sKXKfzh5eHF/mr1Pg/SlyN4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(110136005)(38100700002)(186003)(52536014)(76116006)(316002)(4326008)(64756008)(2906002)(86362001)(8936002)(8676002)(66446008)(66946007)(66476007)(5660300002)(66556008)(122000001)(7696005)(33656002)(6506007)(53546011)(9686003)(71200400001)(55016002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RaYjRLVmdnSDdnbFlUdnVFUnJWVXJEaUphUTNhdzEvYUtUb0IyN2xvWGxz?=
 =?utf-8?B?aVNaY1lOcFRNbmZDZDRFMXNuU29xQUY3ck1FRjQ3YmdzaGtMM1BFV21Yd3dT?=
 =?utf-8?B?WEh3eTlLUXorbEtlMUVCU2FpYnhqSFBqSnZlaFNNcndyTSsxTlEvN0JYSms5?=
 =?utf-8?B?aFJGNExzZUEyaDBXQVcraUFudFo3QWdJbVI4OE5mRnN0QXh6WmdVQkY5bzBu?=
 =?utf-8?B?Wm5CbGVEMHZzY1NicVhPck5ieStGNVdwSC91YStrLzBaMW5rbVEreW0zd0pK?=
 =?utf-8?B?VmgycXBqbXJVK0FRWGJtemUvM25qbGxkdHhzdEhGWUp5a2JBUithSEZwOHZh?=
 =?utf-8?B?MjQ0Y0lNMGR1SThIWVg4ODF0cnBWb1BDeXZwUFZna1Q1WSt3SnZPSUVvbWpv?=
 =?utf-8?B?Y2dLZ3oybkJtbVMvaEJMREpKbHhOM2d2Y2JlRFhjTEgzQXNzSzcwOXEvY1JY?=
 =?utf-8?B?bmpxVVNsdjdlcUNFMm1Sd2NkeDMvMmpzVU9rcTJ1dXJjcitKODdOMTVESzVT?=
 =?utf-8?B?S0RGT3Y5d1F4U2pMZG83d1p0cEpaWXhaMkxOMHRXdll0d29CeW1EaU1aZEpK?=
 =?utf-8?B?M2MzRkoxWUJzTzh6Y1NhQ3djM2xUZWIxY3ZyYVNJNjNQNmVZcHkyK1l0Nzh0?=
 =?utf-8?B?dmZJcVBSVGFBWHhvZmdPRXpkVnhJWmVWb3RJYWwzVUNoVElHelJnUmJNL0FY?=
 =?utf-8?B?amdvWUFMc2xWT0d3QUQrNmY0aWdiUEdpOGo3eFNLLzg3ekd4TmpVdnFHbzYv?=
 =?utf-8?B?NWowSExKRExIUXJSRktDQ21UVURLNG1XdnVDZ09rRG5zYktJZEQ2SVVYRW5r?=
 =?utf-8?B?QVg2ZXRLdlZIdVoyT3Q1a296SWFLdlh6OE5IYjNhYXFwMGJPcW1HOUVRVHRw?=
 =?utf-8?B?NkQ1bUlXd3p4NmdmY1hZUlo4Zy9SOGt3RnltRmZaQjB2Qzh1QWl5dmZIbUtu?=
 =?utf-8?B?b1dLZG1EcFNRVUZra2d5dmN5dG5Ddk1KaDNHVWZrUU1PQ0oxV3hldHZ0R1pL?=
 =?utf-8?B?N2tRd0FEYkNpSHFvTDA3R3FuV2ZLT1ZOUVJzRUZQSEVDR20rK1N6MnFodUJG?=
 =?utf-8?B?d0ZIQ1NqVXBJWWowYjNFdHg3SnZUREN4ZWxxUENlN24xQmdodmhNWERqMTkx?=
 =?utf-8?B?R3dLdmhuRDhIVGZjVFhlc3hPOWhsVDBabFpWMkM2bWNQdHdPVkpkWTkxK1pH?=
 =?utf-8?B?TlBsaDRlSG9DZzdvaFNEYXRrSisxUnJGMGVsQWthcWlCT0d4aEt1ZlFxdTBp?=
 =?utf-8?B?ZjNFUXB4RnNEY1JsaHVDZ3lwbmN2b05sNE5CNWh3S1BCTlk0YzBoajUyQW9J?=
 =?utf-8?B?RC9SaXhQTnhhVW5PUi9vVG1BeWZpcFJVZ1IyYkJONWk1NGp6NmN6d3ZlU1dx?=
 =?utf-8?B?QmU5a2ZycSs0clM3eHF5OXBFdW1ER0RET0h5OE9NQkdERGJhbWtBbmRROVRq?=
 =?utf-8?B?RlV6eXVETTVzRk0zNTVXZktUeHV4RCsrMUNFWUpSd2tVVFRvUjByWXJzSit5?=
 =?utf-8?B?bG9nMkhWbEczdWtYRURDNWk1NDg2UytkQVJHT05vWkFKUTNaNXgwVHIxajh2?=
 =?utf-8?B?RGxKRjYrcGNERzRpSXR6LzlXakIrN3dCNzFiT0ZTOVJZMnVGSUErYk1Od25a?=
 =?utf-8?B?SGdtSG14bTd1MmpXbFNTOWo5MEVJZlZhQkZhaDFEOFE2NEdncUtBRU5xaS9p?=
 =?utf-8?B?alVTK01lTW5CRU9rUUljUTdScFV2N2lwS1lhTnAxRk82V2szdkJUVi9xRk1w?=
 =?utf-8?B?ekFrWWhvbzdpZ3hOczFySzErTVNzZ1FyVEQvblN0ZWQ3aUhWK0NVeDNTT1Vy?=
 =?utf-8?B?cXdnME9ncHcrVjJ3czMxTDhST0FHWGk1ZWtLOTMvajdJWWtFZjJDM28rZ3Zv?=
 =?utf-8?Q?ANgwZ609YyEgZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb74b5c-8d6c-45cd-454c-08d935441d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 06:08:11.8395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dg++/sCsUhpHENg1z5EPw14rTqdhkp+/CM6hn3/ckShiswkvR9LdLJX1ppCiqxTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

AFAIK, that expression is legal (some code analyzer may warn on value of 4*max_wgp_per_sh); similar kind is used in rotate shift operations.

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, June 22, 2021 7:56 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting

[AMD Official Use Only]

Thanks Lijo.
However, I'm not quite sure whether " 0xffffffff << (4 * max_wgp_per_sh);" is a valid expression since it kind of triggers some overflow.
Can that work for non-x86 platform or even work reliably for x86 platform?

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, June 21, 2021 8:08 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
> 
> One minor comment below, apart from that the series looks good.
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> On 6/21/2021 12:30 PM, Evan Quan wrote:
> > Add missing settings for SQC bits. And correct some confusing logics 
> > around active wgp bitmap calculation.
> >
> > Change-Id: If4992e175fd61d5609b00328cbe21f487517d039
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> > V1->V2:
> >    - restore correct tcp_harvest setting for NV10 and NV12
> >    - move asic type guard upper layer for better readability
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 103 ++++++++++++++------
> -----
> >   1 file changed, 57 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 15ae9e33b925..384b95fbad8b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -5090,47 +5090,50 @@ static void gfx_v10_0_tcp_harvest(struct
> amdgpu_device *adev)
> >   		4 + /* RMI */
> >   		1); /* SQG */
> >
> > -	if (adev->asic_type == CHIP_NAVI10 ||
> > -	    adev->asic_type == CHIP_NAVI14 ||
> > -	    adev->asic_type == CHIP_NAVI12) {
> > -		mutex_lock(&adev->grbm_idx_mutex);
> > -		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
> > -			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> > -				gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
> > -				wgp_active_bitmap =
> gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
> > -				/*
> > -				 * Set corresponding TCP bits for the inactive
> WGPs in
> > -				 * GCRD_SA_TARGETS_DISABLE
> > -				 */
> > -				gcrd_targets_disable_tcp = 0;
> > -				/* Set TCP & SQC bits in
> UTCL1_UTCL0_INVREQ_DISABLE */
> > -				utcl_invreq_disable = 0;
> > -
> > -				for (k = 0; k < max_wgp_per_sh; k++) {
> > -					if (!(wgp_active_bitmap & (1 << k))) {
> > -						gcrd_targets_disable_tcp |=
> 3 << (2 * k);
> > -						utcl_invreq_disable |= (3 <<
> (2 * k)) |
> > -							(3 << (2 *
> (max_wgp_per_sh + k)));
> > -					}
> > +	mutex_lock(&adev->grbm_idx_mutex);
> > +	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
> > +		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> > +			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
> > +			wgp_active_bitmap =
> gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
> > +			/*
> > +			 * Set corresponding TCP bits for the inactive WGPs in
> > +			 * GCRD_SA_TARGETS_DISABLE
> > +			 */
> > +			gcrd_targets_disable_tcp = 0;
> > +			/* Set TCP & SQC bits in
> UTCL1_UTCL0_INVREQ_DISABLE */
> > +			utcl_invreq_disable = 0;
> > +
> > +			for (k = 0; k < max_wgp_per_sh; k++) {
> > +				if (!(wgp_active_bitmap & (1 << k))) {
> > +					gcrd_targets_disable_tcp |= 3 << (2 *
> k);
> > +					gcrd_targets_disable_tcp |= 1 << (k +
> (max_wgp_per_sh * 2));
> > +					utcl_invreq_disable |= (3 << (2 * k)) |
> > +						(3 << (2 * (max_wgp_per_sh
> + k)));
> >   				}
> > -
> > -				tmp = RREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE);
> > -				/* only override TCP & SQC bits */
> > -				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
> > -				tmp |= (utcl_invreq_disable &
> utcl_invreq_disable_mask);
> > -				WREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
> > -
> > -				tmp = RREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE);
> > -				/* only override TCP bits */
> > -				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
> > -				tmp |= (gcrd_targets_disable_tcp &
> gcrd_targets_disable_mask);
> > -				WREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE, tmp);
> >   			}
> > -		}
> >
> > -		gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> > -		mutex_unlock(&adev->grbm_idx_mutex);
> > +			tmp = RREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE);
> > +			/* only override TCP & SQC bits */
> > +			if (adev->asic_type == CHIP_NAVI14)
> > +				tmp &= 0xff000000;
> > +			else
> > +				tmp &=0xfff00000;
> 
> For the disable field mask calculation (which is the value that is 
> applied finally), there is no ASIC check. The above code may utilize 
> the same method as in the original code without ASIC check.
> 
> tmp &= 0xffffffff << (4 * max_wgp_per_sh);
> 
> Same for below case also - 3*max_wgp_per_sh.
> 
> Thanks,
> Lijo
> 
> > +			tmp |= (utcl_invreq_disable &
> utcl_invreq_disable_mask);
> > +			WREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
> > +
> > +			tmp = RREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE);
> > +			/* only override TCP & SQC bits */
> > +			if (adev->asic_type == CHIP_NAVI14)
> > +				tmp &= 0xfffc0000;
> > +			else
> > +				tmp &= 0xffff8000;
> > +			tmp |= (gcrd_targets_disable_tcp &
> gcrd_targets_disable_mask);
> > +			WREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE, tmp);
> > +		}
> >   	}
> > +
> > +	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> > +	mutex_unlock(&adev->grbm_idx_mutex);
> >   }
> >
> >   static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev) @@
> > -7408,7 +7411,10 @@ static int gfx_v10_0_hw_init(void *handle)
> >   	 * init golden registers and rlc resume may override some registers,
> >   	 * reconfig them here
> >   	 */
> > -	gfx_v10_0_tcp_harvest(adev);
> > +	if (adev->asic_type == CHIP_NAVI10 ||
> > +	    adev->asic_type == CHIP_NAVI14 ||
> > +	    adev->asic_type == CHIP_NAVI12)
> > +		gfx_v10_0_tcp_harvest(adev);
> >
> >   	r = gfx_v10_0_cp_resume(adev);
> >   	if (r)
> > @@ -9328,17 +9334,22 @@ static void
> > gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device
> *
> >
> >   static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct
> amdgpu_device *adev)
> >   {
> > -	u32 data, wgp_bitmask;
> > -	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
> > -	data |= RREG32_SOC15(GC, 0,
> mmGC_USER_SHADER_ARRAY_CONFIG);
> > +	u32 disabled_mask =
> > +		~amdgpu_gfx_create_bitmask(adev-
> >gfx.config.max_cu_per_sh >> 1);
> > +	u32 efuse_setting = 0;
> > +	u32 vbios_setting = 0;
> > +
> > +	efuse_setting = RREG32_SOC15(GC, 0,
> mmCC_GC_SHADER_ARRAY_CONFIG);
> > +	efuse_setting &=
> CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> > +	efuse_setting >>=
> CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> >
> > -	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> > -	data >>=
> CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> > +	vbios_setting = RREG32_SOC15(GC, 0,
> mmGC_USER_SHADER_ARRAY_CONFIG);
> > +	vbios_setting &=
> GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> > +	vbios_setting >>=
> GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> >
> > -	wgp_bitmask =
> > -		amdgpu_gfx_create_bitmask(adev-
> >gfx.config.max_cu_per_sh >> 1);
> > +	disabled_mask |= efuse_setting | vbios_setting;
> >
> > -	return (~data) & wgp_bitmask;
> > +	return (~disabled_mask);
> >   }
> >
> >   static u32 gfx_v10_0_get_cu_active_bitmap_per_sh(struct
> > amdgpu_device *adev)
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
