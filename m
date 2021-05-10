Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5FC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 06:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E6961104
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 06:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E6961104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E876E053;
	Mon, 10 May 2021 06:33:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D506E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 06:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBnxfPiKBi/eVxPGFbtdQHTGiEGKEagsio/3M3b6PT3+JHXTt2InvbjULYNx6NRwxteCluikjCzOumI0cULU3RUmtAMV7p720Sl3njyli+UP2Xj8DtTU5WveA4EU/2zJSJw1ZGjRyILTR/jn4IyrJY3kHFCXxgtRkFWTXZOXwnnnXS/8Q322Cpreg+vcQFhTlcheDDDXZqzputgR32Lv6NZRs4IRHworRtQf41IU/evRSqKNDZy1GqHLWndbjxEU655+Y7MAzyID25LADpG45RBVEQrPMUdMXOHZ+a6As1HeDdpGOdme8U1ANZeqN6AbLMQfy5Zwxpux4ABPIPIhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhlgodaDIai64NIGbPiatdK/d9+zmuE0M7/ggYVGGdE=;
 b=n/6qOkb56uzrTKlCdLmmXif7DvYTS9mq91BfF5AgP6KKAI5ALclxPmkRiT0bmxTmu0LlnrAXnDtPKoggR5cUISLX+mUWmNN3hgaGnFghN+Bs8f5cK2gBpfc3fToUSvqIHSiSc8WGtDa/roEZg2LH/xRJJZZM9vzDCjZNedVHZIHcBqyaC2+vi403ajKBGlHbaSZtLLKrkDFGI0VIxlaScj1U0etkl6mAbf9xJ/Fq3xYrZqbEvkYK/mSBmXqgPsXcAKf2YUAdgy3smmEAIkd8ppiuuGELHG1GMb3aACujSEcjrIJTBHQZPnidTWIZU/LLcCED6K/kX/rgNG84ZA+tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhlgodaDIai64NIGbPiatdK/d9+zmuE0M7/ggYVGGdE=;
 b=r4DdJ4Ix/QJTOzbUuXekz089zyU97pXNWRVn6kG3Ym5AzbDy3UJA6+UJvkXbCzoIN5tB0nThoMfV8gpwdXYCtxJ533zZq0fEYcwGhtXbxLaKMFlClUaI5gPgWmS5rXftbepbtyHXArzH7B7rw/9ihyoURbMHHBdb2tUYuB+lCfQ=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 06:33:06 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 06:33:06 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Nieto, David M"
 <David.Nieto@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdA=
Date: Mon, 10 May 2021 06:33:06 +0000
Message-ID: <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
In-Reply-To: <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: alexdeucher@gmail.com,David.Nieto@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T06:32:56Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=819905d8-3459-4b95-b2af-9d3abe3e9a14;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ed65742-f31c-4e1c-7100-08d9137d789a
x-ms-traffictypediagnostic: CH0PR12MB5219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5219101D800ADAE80E52FEE1F8549@CH0PR12MB5219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2UO6Pz6ZRFpzPx2FCppOVmaKWPlxsJDYtFwalCHxHqOL2rvHT77vsx8a/SB8uxtjmU1Dv0JzYWvS1687/d4TaRzRprT00g5Y4Zp6aLggXchvD1QS8VUbsCSTNUEq+t51afLd22VWo2o4lePWUODoCJ925yixQVIB6XtYWEU/beNXZ1P7zRdmqLnLk45WmET/hYT0Fy7xUNQhGIw0zovRS/XtHPvC4OrQk+q+9F7qKlz+3jXOA75i+Ls4rUo8eTfJ0S/a+EPDr3JQzaTrk75DqM4NoGsYMP8VKsb4AbP2QAcvRsxl1TeqaNB+7fJK6RG7M2NCev+QPp6BoL1FWNdJatX/cC9td1BraBPzl9NaqXJ/v6wHn0I1fI3Sm6MEk97Ik245QfdyUOyiFC3z1Vh8eg/EMxZslSWnzenhYa8DHrJRTJp3qJdSMHFxBdaqFG2Vmne3o8ajH0oLeCVfI4L2KjV6kU7IM/v0ydwPtTOepS/vpdRsp435cka98vgGIKhNiSiENJhbNepqGC1qmogQYyqK57LG+cQjdP8JcDtqtoyTrWcKc7Ptwm9vR1AGPmQzMluj7t7C/dYvx7oCTBp+tt/hsU67rnEwVayZIs/Ru88K2PDHL8vhOPbsR4XBEXGFYnP8JJxhXWgouY21uJYzRAgUlF/jvjf9Imn2xE04p0uAXL12gL9wYPuinJXMxMP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66446008)(76116006)(110136005)(54906003)(66946007)(64756008)(66556008)(55016002)(66476007)(83380400001)(186003)(316002)(33656002)(6636002)(9686003)(52536014)(5660300002)(38100700002)(4326008)(966005)(86362001)(6506007)(45080400002)(7696005)(53546011)(26005)(8936002)(478600001)(122000001)(2906002)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d9JwfL+ZFfdUgCpLgIhkrv0kdBt3MptQu+oMcgadwNcsIlSN8Hn7OZpPI5l6?=
 =?us-ascii?Q?Cn9bTDO7nUSgt/YAb9OmukKEDJk6DkUR3jhxV8i/Tc+y+EjwwzrK4bGmFxZb?=
 =?us-ascii?Q?0qdqH+LWvB0i/Vez423UKAOC+ljrbE4nyTJcsUMGyXfiE/w3pZ++Ux1w0A2l?=
 =?us-ascii?Q?KAtb3ZUMUJFa7hel1yOmqQT3A8ftBEyckvodcrUvy83aD69T9nYEw9sRx7y0?=
 =?us-ascii?Q?ykY/0YcDETo9ZrmCnJQEu3JLnH/N/0siTcomKRWcfTw8AgbkCVEM/YlTlQsP?=
 =?us-ascii?Q?Bu7WIdT3+tw4wM3eM3hXJZBl8FVkZTADWOWSrQA+I/WoIg523XonFcuEgvFn?=
 =?us-ascii?Q?UcbWkLli2VyooM+T51DtqNSWb77b9Zts3mVmlyKAsBdakUQnOabI2tUydgak?=
 =?us-ascii?Q?s4zPRwD8FpepFcOfaoRScvl6pPNLgPkAiyjnTd3bgTtEz0af3Jp6SMedUCzF?=
 =?us-ascii?Q?goZ1sl0r6cOdyV2t4yQhvvhxQVWg4HWwlf4vG5Ub3ugw7aCmsE2DH3bRCVHe?=
 =?us-ascii?Q?zSIm+oRKwnTRwXB87hgjdbJ4Wtx2OxueOHOvS8VfDrHMFfNBsdvVdrWMLJd6?=
 =?us-ascii?Q?g1Pdd0+6I+HC8jkbks1gG937A4JbMlq6Ux1caHkC8K+EaVnPscukRhq6p6UA?=
 =?us-ascii?Q?8GYqzIvMrl9LrVy/R4I3PejWK1sxq8zpQSe7nwRtHJC3jrYurcmAwPJLCFUx?=
 =?us-ascii?Q?ipSGk80V7RFy2q463kt5BiqOJN8gkljQCy3KzQr7+8w2KNDssK5hy4SmJYBW?=
 =?us-ascii?Q?kVE+M2uV6OwibTMX1P1yO4u4nYNnI8zLNFvHJAa5DzsWAlWU0AK/PsEED1Jr?=
 =?us-ascii?Q?e5UbEq78iTZWcrgUBEkgM5WdE5QwBwWtzmq8xWIxW2Tdzff2vJoHG3E0+y/y?=
 =?us-ascii?Q?2LSAbjeDJESjqqM5wJioJY9NurhkTGc8F0uXYRjhSgs7BmVg7ouZMMRVAKOn?=
 =?us-ascii?Q?NlJxa8buaeIbYpWLbp11w05isgirEvMnUjL05BmU93m2oq+CiYs5fYWnHQX8?=
 =?us-ascii?Q?UHy8LnXDyjliFxZwyHTpnfv+TmR9wYYg+mskfrcQLH2ItzMgrDpdGokRDBLf?=
 =?us-ascii?Q?Y9H1f4L3mMBaXnd5PUUzkfOzaSVXGHKagzkcuDR4tvwyox9f7cSx4GgNyVx2?=
 =?us-ascii?Q?SpHfSYyONuJRNj5Gt6DOKo8X36Vl2pcNSi+PBknJbazEra6OLVrhhG9vSunJ?=
 =?us-ascii?Q?ZP7CdookIifxrvB5oNu0uYyRCrCPrmVVINKNGuq8bJni0WB+rNhuJ8I1mpxl?=
 =?us-ascii?Q?M8z+0Rwb1LQD63PyABb8TVOsxzxe1YNxL9Be6Ra+c4Eui0I02K7cx8drsoTz?=
 =?us-ascii?Q?Yx3dJYNO5FsqYnzWwNRsS/Qw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed65742-f31c-4e1c-7100-08d9137d789a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 06:33:06.2941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvdbT0e+XeyF48rskzd8A1D2/v8NIp1O7Gc0TE0a5YdJpaFjX+Ri3ed8Sa/Kos7GPei7T4Yc8l3drUsyEkjh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

With a second thought, 
__u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs serial_number already exposes it.

Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex Deucher @Nieto, David M

Best regards,
Jiawei

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Sunday, May 9, 2021 11:59 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> 20 should be serial char size now instead of 16.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>

Please make sure this keeps proper 64 bit alignment in the structure.

Alex


> ---
>  include/uapi/drm/amdgpu_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h 
> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da 
> 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>         __u8 vbios_pn[64];
>         __u32 version;
>         __u8 date[32];
> -       __u8 serial[16];
> +       __u8 serial[20];
>         __u32 dev_id;
>         __u32 rev_id;
>         __u32 sub_dev_id;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJi
> awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=kAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;rese
> rved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
