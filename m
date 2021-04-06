Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6079EC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 14:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245C2613AE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 14:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245C2613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49A489EA3;
	Tue,  6 Apr 2021 14:22:42 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680083.outbound.protection.outlook.com [40.107.68.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F99689EA3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 14:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlPhhS7IjYQGMOpjJiifQs883CySTR830PdobpaYBr0RhGIp+Zw8y5JhWmpVl++KyNLJkb4rPkN7dT25nQ+Nuot+b4boq7VoCKiwpgMwUAZ7WXCDL1N/m+50zcOHuWEakpyTr/3dsA2XYvnqMwLh94h2Xgz9RizWZ7v1bu2FH7GjaIGv4edvhuzaGSJYqrW1Ycccyhu+A/8D19oA7OSnaGNH8hKv9HvG5K62iDHBVK+kX3C/++lj30pAGTNhJtFaRUSgS/PXtSdEmJp51VY9ZReLgr4czScK53BvfQOdVHyuiwx7aDNGJX8SI/7mLfpkIry0zvsLk4AbAasy3v9VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V90IocnK5Vz42BZYmpkpZFCsJWcZ1mgZUt2YW3sjmQ=;
 b=Qu7H4ZZ7SeRfWfSkDV1ExKKr7BsOJN1zb5LnDh5hvm1UcmSqBQqVQ4MdrBVu8OZlB65cEOl20ZLIGuJMzGhQNpeDHnUE9ARBwuzWLAXmgoGvDsnqZLqUxWLSYEabBqyFe2qA8510MCk/uPwPFpSqPttl5b9hIwjec1f58QA0duG8L52iYDtfyrpOz0WNRCZSJJqbpd7h77rrS8aaTH6zwaTeXeEv8x9IunJKtmjDAQNug/a45Fs2uqW/a/vp86qvFhn4t9Moz1jcTlQaFa8KVDM9l2o9lAVG6xx0wclzJI+XZixnE4qBcyNu5AZc7CaLKtsSxiyB7IiTZtGVABDpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V90IocnK5Vz42BZYmpkpZFCsJWcZ1mgZUt2YW3sjmQ=;
 b=WuCNW5bXsWQzQ0fivqkhR2hI/IQC2jTiQpyhURLw9nRpztK0HYfbd+l9StQBEBEv72LziLC+dPgs+gc+hvbqxikLFGdwIfSHROuzBdqhJFaLWhIIIXACSc9tRI98wSTbcm+uE/r5bqtXyARLRrZNiLKYH+OiomkUfl2j0q+IGCo=
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 (2603:10b6:300:de::20) by MW2PR12MB2587.namprd12.prod.outlook.com
 (2603:10b6:907:f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 14:22:39 +0000
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::3919:738d:65f7:f278]) by MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::3919:738d:65f7:f278%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 14:22:39 +0000
From: "Shih, Jude" <Jude.Shih@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Thread-Topic: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Thread-Index: AQHXKupeJ4UitXbZEkKHCOE5W2WpcKqnhXMAgAADjuA=
Date: Tue, 6 Apr 2021 14:22:39 +0000
Message-ID: <MWHPR1201MB2494C84F298E6C540BB76314F7769@MWHPR1201MB2494.namprd12.prod.outlook.com>
References: <20210406134001.46915-1-shenshih@amd.com>
 <bb10f195-2205-a3a0-498f-94668ddb4bb2@amd.com>
In-Reply-To: <bb10f195-2205-a3a0-498f-94668ddb4bb2@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-06T14:22:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1e0c1aa7-67df-4e4c-af5e-d6f5da281e36;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [219.84.232.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cda49ca-212f-4b75-748a-08d8f9076ed8
x-ms-traffictypediagnostic: MW2PR12MB2587:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB2587EB1D6F8A9AC9FAE83AC2F7769@MW2PR12MB2587.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsnTteNx4UjeujP43HP8GQTJWT3zWXjsrJn3C1DpeMNWbjpydumTpUiJK/2FLJWN+/EZFEywZA6OQ7FBw3Jp7kmUkRpzOZrvyyeCPTP2ufjnVkRlLjntG+P4F/yQkcj+dn0Kj6pTqYEFBahNuqvP41Wkkj7pqseHHic0R2F17JkMXnJY0+YFJE7T8eNQN8ynu9pMw/ywRAewbv/R2+H/bVHX3RRvNlNBEl1l9WtSL67smHnc3XLacn00rUaDE26PPriJkVriRoRDSwP6Z+x7mSduz8JEcWgQ1p2H36IKfi2cZHjVewe2mEA/8eCjKga5EkbPblBNwly77PhtRBrvjybg+Srn4oPuy8zXAAPL016lean7JUhwABKhlvJDVgCja5bhnIdAY4ZjLXnAiN6SlGRsAOw7H10YKoz147I52M6M+YJNCoM/nOi7hoOjtwzDB+bS8RCTen10H1K3JE8SDBinwVfizbqzO9x1POX9Qz75qdeilu8kB6t48VHHy7ao7SnzmVAtTTEXCfx6NyMS6bBpUk99IixUh0h9dfv6ApDUH8/fyaKy+yueaNahv3RLvUtCTlcT+GvtVeht3k3vEYAguKocBYcHK2scNZmhWHIhrTYduemRfCFKrTTw2/C1/RvZNga/1b5eXje8ciF0fnj1NJ6le6jk34L2MdzhY+8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB2494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(71200400001)(2906002)(7696005)(52536014)(4326008)(83380400001)(478600001)(54906003)(26005)(38100700001)(186003)(76116006)(55016002)(6506007)(66476007)(66946007)(66446008)(53546011)(64756008)(86362001)(66556008)(316002)(5660300002)(110136005)(8936002)(8676002)(9686003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?OTZGQ2x0OVNRNlNVR2FvQXlvTys4STh3LytZUFNoblBzbXpvc2ZDU1hUcUdZ?=
 =?utf-8?B?ZlF6UTFkaGFCUnlFbGV3eGtXWDI3amhOMXR2MWVDUnY1NGVwWDBlcWdSem9I?=
 =?utf-8?B?eUJIUDIrcjczamd4S2xDQU8rbTJrYVB2KzErWGpyRVZUcDZpUTgwU3hiaEJT?=
 =?utf-8?B?cWpVN1lCcnNKLzkwZWIzRXpiMDhvQkxhZmdVYkkxeHhGU3JzRW8xRVVTOUxG?=
 =?utf-8?B?dzJYMGpqS2xQK3JpU09WSkdCV3BqS0U3bGsxdG4reSt3N3RYNHBkUW1aM3hR?=
 =?utf-8?B?NlNTeUdUOC9IS0llM2d1UGpSblVwMUhaTXBrY1llNFRPQXdvaFVrUzZoMVpB?=
 =?utf-8?B?M1lqcktKbnhBanNYWCtzN2ljdkJrMzlQbEpvc0tvQWR5aDJNR2hiTW96VWd4?=
 =?utf-8?B?OHlBSnlLYkFXeWZvdjFiWlhoMGw4WlpCdjdTUElMZnF0TUJqcXB6U1pHOTZI?=
 =?utf-8?B?L2RycnlaWXdiV2kzNTc5d0kzbW8yc1JSRFZRMDg4ZGdCSG9rUUVyNEd0SUxH?=
 =?utf-8?B?SU51NEFZVFltMEdFVE5oN2gzSzg5c0t5bVRwcEhKaUlHOFdad2t2d3kyNi9N?=
 =?utf-8?B?dkI2RGdhNURKaDZSY0ltSmZVQjdidHFENWtYUDNZa2lJTzVEQ0ZUSWhPSnVQ?=
 =?utf-8?B?aWxiaGtOMjN1bi9VZDBuOUVqaGY2bVdpSk85cEM0U2hyazZqN0V5Yll4NFpJ?=
 =?utf-8?B?aGNPYVd5ZEpXOWZmUzBycXNHUit3NXJFV016dE1tWFExazZPZGxuMEI2V1ht?=
 =?utf-8?B?QjROZk9QdXUxR054ZmpnNU9BclF5dFh0djQxd0FNenkwbG0yZzdhVUplSW5M?=
 =?utf-8?B?TmxZUDRXbEt2RTMzWkNNTVJWekErWUtIRytxL0lIa2l0ZlNuSXRRbThmQzhh?=
 =?utf-8?B?Q3N6em9CNHN4MzRkOU9SK3IyamZXbjNJNXYwaVhuK05kNS9sNVI4ZSs2S1h2?=
 =?utf-8?B?aW9YZkh2YXphMThqUDFwSG9UNmxaaC81UVJOWlFwOWNPZHdwY05mdThMYTYv?=
 =?utf-8?B?cUNPWWpRRnZWK2VjTmo3OUpwWTVQK1NyYjRXalE0bjlkT2JrMUxwd2ZyZFZv?=
 =?utf-8?B?dlNRY0xPdEZNendxNy9hUGpYY2MzQ1pFOHB5RXZNVGpYT1c3eVRIK1FSbUdG?=
 =?utf-8?B?dS9aRERtaysreHoyRWNWR2Z1VEdpY01tVm9EV2E5Sm5tS3hSc20zNUdpbEdi?=
 =?utf-8?B?bUxSQ2YyS1V5eWIzVzV5WTcwdjA4LzJBcFBydnhsN3ZSOUV0UkhlM3VwTVdt?=
 =?utf-8?B?QyszeEgyeUhPRVg5eGIvcGNFSCtnUWc5dnJQUWxNTjN0SjlJNVVMdjh1dWJo?=
 =?utf-8?B?a1dJY05sQ0pkK1VURlg1NjNtOFVyTzhHMGRicVd0ZGFqSGFLUDdYdlpEM1Jj?=
 =?utf-8?B?RDFJWEhiZzNuM09ib0xiMTR4cUlSaEQ5ZytWRE1RVWNXdGxGcURIRCtXZTRP?=
 =?utf-8?B?S0t1SjlOMlRsQnNhRDF3UVJGTWhmTG1wL1l2eGRzdzgzbGFrVjV2VGI1Y1hn?=
 =?utf-8?B?SFJTVERqL0wzRjlmNUNaemZBaDg5QmFLeFJQY0VFQ0pyVGlBUGM4dlc2bnAz?=
 =?utf-8?B?aG8wVTIxYTJaYXFRZDFEdlY4aEpOb3lVaklwdmhYd0J6NEgwSjRGVzJ3T3Vj?=
 =?utf-8?B?NmtkaWNoQ1ByZGdtYzZvRFg5ZkgvbTF4aFFSWkUvUHd2UW5NckFlK0Z3VVdH?=
 =?utf-8?B?b3k5Ky8xa2U2VnNyWHRqUDlWcmc1UDQza01CZ3h4VVlWVGV0THBJWXVEYXl5?=
 =?utf-8?Q?10dZUOdNTTQNZ/ZnI1tzFGofK3cDY2OvsHCLeDU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cda49ca-212f-4b75-748a-08d8f9076ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 14:22:39.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tjxo1bk0VXdOh+Ubsw6KXHLYYpi1CXfR5evjs3Hz8+XbpYEM8JD9gwV791yly71Ncp3P81vM/+VMw8IAV5hAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2587
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hung,
 Cruise" <Cruise.Hung@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Nicholas,

Does this completion need to be on the amdgpu device itself?

I would prefer if we keep this as needed within DM itself if possible.

=> do you mean move it to amdgpu_display_manager in amdgpu_dm.h as global variable?

My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't require the user to have to flip this on by default later. I think I'd prefer this still as a DISABLE option if we want to leave it for users to debug any potential issues.
=> do you mean DC_ENABLE_DMUB_AUX = 0x10 => DC_DISABLE_DMUB_AUX = 0x10
and amdgpu_dc_debug_mask = 0x10 as default to turn it off?

Thanks,

Best Regards,

Jude

-----Original Message-----
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com> 
Sent: Tuesday, April 6, 2021 10:04 PM
To: Shih, Jude <Jude.Shih@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Hung, Cruise <Cruise.Hung@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source define/complete/debug flag

On 2021-04-06 9:40 a.m., Jude Shih wrote:
> [Why & How]
> We use outbox interrupt that allows us to do the AUX via DMUB 
> Therefore, we need to add some irq source related definition in the 
> header files; Also, I added debug flag that allows us to turn it 
> on/off for testing purpose.
> 
> Signed-off-by: Jude Shih <shenshih@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 ++
>   drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
>   drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 963ecfd84347..7e64fc5e0dcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -923,6 +923,7 @@ struct amdgpu_device {
>   	struct amdgpu_irq_src		pageflip_irq;
>   	struct amdgpu_irq_src		hpd_irq;
>   	struct amdgpu_irq_src		dmub_trace_irq;
> +	struct amdgpu_irq_src		dmub_outbox_irq;
>   
>   	/* rings */
>   	u64				fence_context;
> @@ -1077,6 +1078,7 @@ struct amdgpu_device {
>   
>   	bool                            in_pci_err_recovery;
>   	struct pci_saved_state          *pci_state;
> +	struct completion dmub_aux_transfer_done;

Does this completion need to be on the amdgpu device itself?

I would prefer if we keep this as needed within DM itself if possible.

>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
> *ddev) diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 43ed6291b2b8..097672cc78a1 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -227,7 +227,8 @@ enum DC_DEBUG_MASK {
>   	DC_DISABLE_PIPE_SPLIT = 0x1,
>   	DC_DISABLE_STUTTER = 0x2,
>   	DC_DISABLE_DSC = 0x4,
> -	DC_DISABLE_CLOCK_GATING = 0x8
> +	DC_DISABLE_CLOCK_GATING = 0x8,
> +	DC_ENABLE_DMUB_AUX = 0x10,

My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't require the user to have to flip this on by default later. I think I'd prefer this still as a DISABLE option if we want to leave it for users to debug any potential issues.

If there's no value in having end users debug issues by setting this bit then we should keep it as a dc->debug default in DCN resource.

Regards,
Nicholas Kazlauskas

>   };
>   
>   enum amd_dpm_forced_level;
> diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h 
> b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> index e2bffcae273a..754170a86ea4 100644
> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> @@ -1132,5 +1132,7 @@
>   
>   #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
>   #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8
>   
>   #endif // __IRQSRCS_DCN_1_0_H__
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
