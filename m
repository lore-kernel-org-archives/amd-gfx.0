Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9857EC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 14:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC1520709
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 14:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QJynBP5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC1520709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBE56E0D6;
	Wed, 22 Jul 2020 14:29:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCDD8918F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 14:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4GXxzYTwn1P1/p2XQQgWMoProROx0sMKwPQTV0WyzObzUaALuosmlx7+c6tneQ9vtZVOupbOFcvCPmHyt1dcS5r5aeh6aGUwDKuyyRN4ILLD4DwWAoIGFbW5sdeBwKcJhN15MLM41WSChx+ryxbIa19SJLLmm6u11EFxdfkHpzfGu3IbEH+zc+THn+NdVJ+ckhpycv41+ipTgOZFYExvMcKIxYwduIhoOpsVQmPrerjSDMBqC8IIM+HJxGc3LEo4gZTmXO9S+miuLJ7Sr/i3In2iaibXDiXs/Tu8ghkHQAe+oqQPskbZUxyRougyTFwPCWF9hGLt59Qne4FoYB/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJtPwXLrPPwx98XU+TEuYBOwzH2Hx7YsFobHluXExaA=;
 b=FD4ZDQ8qJSt3sVEvnqKU0aDadWwa0l0C8WvIb9OeJo3c8UzOvREfEHxgRIun+MS003CnzuRoDQNRvpMwUdk7bm/OekCmSz2GLIIAKCuhCmT5Or9ufIsx8pZILeELpuqJSoRmKaJ5SbenGwSIfW/j1TXHwPYgHU6s6JJPvMt5+iNNVwR9UAjmupVmS4mjehQKS1uhHwP49CxdxJkTuGeHvcsmDBvj3xpOwUsLrlIO0KUm0O4cuMhWnvpvEHv9+HaRwABAu58yRL0pghIjymZm3flE2aEM7Bpd63hdqqNLr7XeY4dvY5ylvBbi/0yTyJyNzSCc4F4m5aJSYgidCTQVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJtPwXLrPPwx98XU+TEuYBOwzH2Hx7YsFobHluXExaA=;
 b=QJynBP5rDICj3xyK67N13lRSvjmEt0kguu7r4Jd0x/GQNxN6CApqXjZbAEz/pPp+piqjUh+1lkuZJ1Ew4BSeVYFaXPSIH0vo3uFqxMr2Qn4NELfpW3q4PLxFdWbfYY4UjBCXnv0r37wfzrOSGKQt0Qb8aKiTYTPGG2wu4GXQzt4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 14:29:17 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.025; Wed, 22 Jul
 2020 14:29:17 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John"
 <John.Clements@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: calculate actual size instead of hardcode
 size
Thread-Topic: [PATCH 5/5] drm/amdgpu: calculate actual size instead of
 hardcode size
Thread-Index: AQHWX9ZGTGT8/vBmO0+sUjJZjeXVLKkTqF4AgAAATjA=
Date: Wed, 22 Jul 2020 14:29:17 +0000
Message-ID: <CY4PR12MB128738650981C51241CB3895F1790@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-6-guchun.chen@amd.com>
 <c735b1ba-569a-0969-b9ea-d6f33c29ccc7@amd.com>
In-Reply-To: <c735b1ba-569a-0969-b9ea-d6f33c29ccc7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-22T14:29:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6f71deed-cc8b-4eb3-a518-0000732b481b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-22T14:28:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 16e7e6b7-aa8f-4c64-9d40-0000b1e1b126
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-22T14:29:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 91d88f9b-5519-4f5e-8108-00002d2d0c22
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.35.34.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6860e547-33d8-4af8-4df3-08d82e4b9db7
x-ms-traffictypediagnostic: CY4PR1201MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01832DB1A51E5FC653AE0E4BF1790@CY4PR1201MB0183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5eezgWcg4z02b/PzU9nAj4+wVR4/VOouXPS7NnZqFP23q9ZqfP+QJ8WvqZYesO4hV3jjjMsoeRsoFUlim7rV5lRbNhU3X5HuyjNEO47plvLgt7AqwJPxF346/h1V0znUytg0MEMu3fgv/GYCSzdYXSSGUgjrYFNtkm2Av5cqJIjzBv59IkVCG0rtb8xIKZe2xnwJC3Gg25SgiAjDkeUVShJ4POaQ0mdiOQawet6+VN+zUQrq0fAA23QbqFpo6zihQTl40bZzyNWjprtyW1c5t0Wk9Bw1gTRKpN7czoHTSlfug71UQTkOFRJsCM+XJ8i9XS1B25vh8qFh9SZkd6+F0D3tjfIegMFQHZB8X4PrztA3qfGZ9xr+RrPujEBaSMrN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(9686003)(66476007)(7696005)(64756008)(66556008)(66946007)(76116006)(55016002)(83380400001)(6506007)(8936002)(8676002)(66446008)(53546011)(86362001)(71200400001)(316002)(2906002)(5660300002)(110136005)(52536014)(478600001)(186003)(6636002)(26005)(33656002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: s+RNyiWu1J8gn98E+N/u9DgxcIam7Dln6CKbm6XxAWCdk5m88Ad5naMfNVNQaPvTYscVA+EzRuqN7mz2eSe6yZ1+T6SS8zS3XlD3yDEN+PiZ3aZoVuF/PDATtYs8FwvA0smP+oeFppuATSnvEChalwhFx3Ng7SnIHLPjqrHXnDNlffFDDWZL1tT9Xk6VFpKdXMCTzJSY8hp3ZrmrEqVSpsd7L04s4ATvC018IYWv8vHEuggHWWpg6kZ3c5W+NuaH5lERfdhQC7BVika/m0SalHyiuJoeZbIT1PHWzj/0HxeC6B4+6Vpmm0ADu3aqvZbZj2PmHrPdRG9W39mxET15FGYENMMBE/g6uob6IV8FJRYf+5waAfIboh8yYLQyBPvUZR9K+icn1xTt9h2Cd0iQoUBD9HxZ1ncoERLD9NxEfnG4Kc0lqGMV+vf47AiisYdn5cjs2td8ykBoO0+dZrtBpRQqweMF6Q/eYGav97NNEH0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6860e547-33d8-4af8-4df3-08d82e4b9db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 14:29:17.5026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQMGQGSPuFWAKGNpKW0sgT9SwS98FZle5PnruKUppZkuE5O3/hggzQ6SOJlqEc/IoE+D5YzsV33cB7ZYQKmF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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

[AMD Public Use]

Hi Andrey,

Aha, thanks for your reminding, I ignore that comment. Let me update it later.

Regards,
Guchun

-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Wednesday, July 22, 2020 10:26 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: calculate actual size instead of hardcode size


On 7/21/20 11:14 PM, Guchun Chen wrote:
> Use sizeof to get actual size.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 96b63c026bad..a5da108e43c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -34,11 +34,9 @@
>   /*
>    * The 2 macros bellow represent the actual size in bytes that
>    * those entities occupy in the EEPROM memory.
> - * EEPROM_TABLE_RECORD_SIZE is different than 
> sizeof(eeprom_table_record) which
> - * uses uint64 to store 6b fields such as retired_page.


Did you find out the comment above was wrong ?

Andrey


>    */
> -#define EEPROM_TABLE_HEADER_SIZE 20
> -#define EEPROM_TABLE_RECORD_SIZE 24
> +#define EEPROM_TABLE_HEADER_SIZE (sizeof(struct 
> +amdgpu_ras_eeprom_table_header)) #define EEPROM_TABLE_RECORD_SIZE 
> +(sizeof(struct eeprom_table_record))
>   
>   #define EEPROM_ADDRESS_SIZE 0x2
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
