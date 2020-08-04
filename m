Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 06:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891BC20722
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 06:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gOjOLR8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891BC20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E9F6E3DF;
	Tue,  4 Aug 2020 06:31:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D13E6E3DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 06:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRECkgSz4wSoIGessoOyNbvjwELHfK1VucnGoBF6A40VR9FM0gWhoK1JmkMyM077bF0giQjAVMgLSf2EpZiXMhN2KKQEP4ATNu5Y4TGmLkqRFkzCEksb24GKwcgQJNKUN9jlXcESneJbT549RZC+tvaT8WvGjShBItZDEWKalN4Wub38AtMDDFjMEEzLoSLmXXXT3KVlN2BwtrMsDm1mPr8q+zkcq6jDY5UYKqRKRYx24Mnf4Pk8eMEfs2/FMUhuNV/CRl23EDcaolkZhwAl/9Es58MVEPJYkiMCRCPIjGBReSaLEHWKEF/o0ycvKIudOLKvqFeNvHuaKkZhsibDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeARws93jo2bdeJtjZpi8qMjubN2bKNkTXKdqNi0M48=;
 b=I/RJ0MSpAIWZM2VWS3zQSiDS443Yene/dfvFHnxCqUd6xO88hY+M+bskF5k3S3V3PW14mrHRdREERfYhegpusjp6Xq3SAIzVXI1+/pK+U+izFFf3jNaWZJXAxB7xqGZpVQxlMWO6clKxhH0Sa/q9CJVZV6QJXnDJe3kVYVXS8SlYLwQX3qAucyjo7qceUb+MX2s463Jt/PUDZtrPfjLgjqF3qBvTBdrhkGDQLY7ta1QD30R8AGBi3kXAb8VSjOaL8vbZgF8/AtA3EfDpnuhGqvg+pkTG6nZv/nmRbCLF8cveYr7L5YF377WoXacOeRoap9yRBRVOoJ+IGBy22qX4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeARws93jo2bdeJtjZpi8qMjubN2bKNkTXKdqNi0M48=;
 b=gOjOLR8rX7yVfL/iLkIRK0kPN/lcxFOOb+ev5UZXR4MOAR6RFGPEKyH0Li8q9xQj7C5nSMI9qao1qg3pMg8MRdIVp/jJrzhZPx3xAk3vQwvcMsBwb07ApBdT2eZAQUlIB8WP1jcpejwKZ5nb9SKKBalf53IlZMa+4q3yRmdGlqY=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 06:31:25 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 06:31:25 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Thread-Index: AQHWZw9dPDGwF8EN3EaS3izz4/lEOakhttqAgAPsMpCAAeB9sA==
Date: Tue, 4 Aug 2020 06:31:25 +0000
Message-ID: <DM5PR12MB1708B1EBA4B3F695A808F85B844A0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
 <a1c5e0a7-d392-8774-d6a1-decb4f9c3235@amd.com>
 <DM5PR12MB170890EFFDD63DA297CDB254844D0@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB170890EFFDD63DA297CDB254844D0@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=926aec95-41fa-483e-8e1a-0000aaad0075;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-03T01:51:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d409b00b-815b-4e1f-2cdd-08d838400351
x-ms-traffictypediagnostic: DM5PR12MB1867:
x-microsoft-antispam-prvs: <DM5PR12MB18670394444D8B85B26D5C1E844A0@DM5PR12MB1867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pA9sBdHCLyBdkZhhxol90jZF7Pmzd3D3cL++cNUZRuTHrN677BSPJ4riZn0VFlhmJJ4MsbRz91/9TH4GFfk8lXRhz1w/U/zEqxk0+HA4vWvVceGP+fctUiwkxO3n7agqQ49vi/DUyZ2iZm+YmQMVjM6jFX6hJgBdagC3eD2cgEFtWfhYlLcBIQtDOYbouj1g+3ESV7wpQy8UjRqlDDUI6urc9r5o5QvGuCeC6bsJ4UCmSaBrW1esoO3tl8V6T6swVbKeK9Zm0VElI9tAnO5b5/TDPoIoR+lt05l0SuP2jBFTIt7VQHUxhAMT9AlybyCSPt5rscyTiJ2CcagAUPUmGu3do2aWo8+PRDFD3t7h4LY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(186003)(8676002)(66556008)(64756008)(45080400002)(8936002)(71200400001)(66946007)(66446008)(66476007)(76116006)(5660300002)(52536014)(316002)(6916009)(26005)(33656002)(9686003)(83380400001)(53546011)(7696005)(86362001)(966005)(55016002)(478600001)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eBWoMv0NjOxj1exVnDmiyZCcvMsVIeTUD+KNuBoudxBxkogphcdxgLLBrNPofib0ONs4hgn5QyZUIu0wp8Ufxh09cObsP/1OoNztsB8NOpiGZRhAvmO5SduM6hdoPRcteswB822wpoAk8lsxPnSGD1ceO4MfmFzfbfe2abvSghgksb9ImpzNH+hGmcb7MPrplZxKL/rutdUf1o0eOSQeiOYnW22EtM6OYLzXqBjcRUsSqTMb37WmBo7RIotxZXWCQ43oagy4Kf8ZX1Fe2RSLkzxvneAE2wAhQ5SWmHAikjbDQaDdcpK4eRq4PE1GTUaJNMW013J90Sv/1xKLDQyhL9Cq3RSmwjnV4EAxnxqWonb13N17pUHvjlkqQQU5jPvX71Y4d0TYCELHHE5vlmLLpskC/1RFX/xk+Vs17Cn04OFf2kX16Gh/X8TkS4B6iQ8zm99abzXew3MqFcRlD5HRbuB3JZA4kPydAsCM9g2GDiV/oNigu+q7Z5ED8VcDZQgy+xKZzcwTPgN/oUCylH46Cxv/zcdKkrYSk6eK/pp3WEJsZ0Dsfyv6k2fM2Wu9aPN5w5bg7xFYi1hAZDYbZFt/51hJlMYCDQv8fuyl1Y3WgA/O9pB8WmlFWpvK4QsVOWGm3rTc5kfDx3QIczv7EVbHCQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d409b00b-815b-4e1f-2cdd-08d838400351
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 06:31:25.6309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2usdC6fHbPO9kG9mSsvJUaRiRKHnHrvaI+Fmbh9tQTzIVogkIf3xY0QPNtD+USN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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

Ping ... this is a severe bug fix

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Monk
Sent: Monday, August 3, 2020 9:55 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

>>In gfx_v10_0_sw_fini the KIQ ring gets freed. Wouldn't that be the
>>right place to stop the KIQ

KIQ (CPC) will never being stopped (the DISABLE on CPC is skipped for SRIOV ) for SRIOV in SW_FINI because SRIOV relies on KIQ to do world switch

But this is really a weird bug because even with the same approach it doesn't make KIQ (CP) hang on GFX9, only GFX10 need this patch ....

By now I do not have other good explanation or better fix than this one

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, July 31, 2020 9:57 PM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ

In gfx_v10_0_sw_fini the KIQ ring gets freed. Wouldn't that be the right place to stop the KIQ? Otherwise KIQ will hang as soon as someone allocates the memory that was previously used for the KIQ ring buffer and overwrites it with something that's not a valid PM4 packet.

Regards,
  Felix

Am 2020-07-31 um 3:51 a.m. schrieb Monk Liu:
> KIQ will hang if we try below steps:
> modprobe amdgpu
> rmmod amdgpu
> modprobe amdgpu sched_hw_submission=4
>
> the cause is that due to KIQ is always living there even after we
> unload KMD thus when doing the realod of KMD KIQ will crash upon its
> register programed with different values with the previous
> configuration (the config like HQD addr, ring size, is easily changed
> if we alter the sched_hw_submission)
>
> the fix is we must inactive KIQ first before touching any of its
> registgers
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e8..f571e25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6433,6 +6433,9 @@ static int gfx_v10_0_kiq_init_register(struct
> amdgpu_ring *ring)  struct v10_compute_mqd *mqd = ring->mqd_ptr;  int
> j;
>
> +/* activate the queue */
> +WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +
>  /* disable wptr polling */
>  WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C4837e2d566b44af845f608d837503a3b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637320165018899834&amp;sdata=TED%2BkhlYyAIyTmLJAZBBBHHnE6PRg4fpUsZhD9ke%2BPU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
