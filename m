Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20730C282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF473206DA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NSQTbTKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF473206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5D06E34E;
	Wed,  8 Jan 2020 22:55:14 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700051.outbound.protection.outlook.com [40.107.70.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBF16E34E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 22:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOQpFZY9vuo1BO8ALNiC9m/Fq9CTlxEfTBRccz+Wv6/OYo3LSCay8+kedCZ5ZMcZ+mA3zqZNUIRcpQUuH6k6q2FioJryYv0UukHU7h2HJN1fUUWfueiDMKjKBv+CcydQBvqvt+eZ+ekKZISSIXez7KT2LfmZSUiR3mpejdPn40hbmhFJ0CyBZ42jpe2rcreXsT7bM5bhzduMB2Tz7wXhEDqJ1+XIDdUNpl9tZ9qYZSfHWtIfC2slZrBoWSkwb1Z9nWh9c/U2/UHIJRZWaosGe81iVGBEkUOm7uSuAxgVpwfZ9+G+dsrKiZm19lietXXkdb7WY/GCZ7z9v2/we+yElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUnXEPkTVFIg0ZkpMhL/V4vZcDy4aVVKuli7S95MGPc=;
 b=PxNR1wFbLC8VI7a4OrY8A35/JKcMTAOQi98HXl498vDvwT8GCclW0JvdYWcVSAGxQbj7vvKsxiOFj9BKxSou/VEx2aKA8SzTIjlI0jGUFse91CB8h2kVUoUp+wobd/wZvs/RENP6mucdtzKKb0QO6bU/O8EX4tMrLEoUl5Emm+9wK3hjQjgyjQ0iMiVbdbRMogrxXQz4nrlS2L6w9LqRsWZfo6TNOfQXH8icMONLLx5KkSeA2jDUP/YRkfKr0ANje/ABkTpuaXTHrc5/lGsNi4U6EADd65WUYhRRjuZ+2WrmsB0AbUu29RqIk6eMm5B+qhpx5pUsu20FVidXvUs9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUnXEPkTVFIg0ZkpMhL/V4vZcDy4aVVKuli7S95MGPc=;
 b=NSQTbTKm6X1MmgDZrV7fy02i3w9Ti+4hEcPcqul2r4AMDxmoHYCgOFcfZvKpj5F/cxIPV9tHE75b5pgicMhjN2ok/FQqXo2332ozOcrLqV/AjOHxoMv7NH6iuBlwXGSIi8cpyWVf64bKeBXlKusafwFvQJtt2337aa0KTXXCG2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2502.namprd12.prod.outlook.com (10.172.121.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Wed, 8 Jan 2020 22:55:09 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 22:55:09 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu/display: set gpu vm flag for renoir
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200108224910.289731-1-alexander.deucher@amd.com>
 <20200108224910.289731-3-alexander.deucher@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <22c7a06c-b0ad-ea37-da8a-e3ba22df032f@amd.com>
Date: Wed, 8 Jan 2020 17:55:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200108224910.289731-3-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Wed, 8 Jan 2020 22:55:09 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe5ed414-8242-4bb5-3cee-08d7948dcfca
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2502:|CY4PR1201MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2502B2B6A2718807458EF5088C3E0@CY4PR1201MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(199004)(189003)(6486002)(2906002)(81166006)(81156014)(4326008)(8936002)(4744005)(8676002)(26005)(5660300002)(316002)(53546011)(16576012)(186003)(36756003)(52116002)(16526019)(6666004)(478600001)(31686004)(66476007)(31696002)(2616005)(66946007)(956004)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2502;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LLUcXzFVyyUYqmotv/5aGcX+3K3DX2dEgRR4sN0UeLQ6CbMjbO9Mj/DMjLcBu6AQpGtLCPxHHOKl3EGJkjry18xQRCx1H0zBnYY1o30SlmM7zF62OzOA1sGwtAJ6s39g29v7OFapjm6FjN3q0TsYyWzhJ99xhNac48L4glhwWrRTkgteS4F4F4Nl6y8FmiWthsBAAM7co6KUYMQVP/GHMoqUckv/hYAJXeGBGUG+juXkS+89yk4QZXt8A0XE0M8UbH9drQr3LK8jYHvM5Es9tCjGLvg7iEbR+NifEd3pMQvKRm0dDnlx77ycX7ZbX2Qv1efulASQW5iX2V9/ZIqoFoo/mUqOt4+VUPUNI2xXZgc+dYAyVXThmiznhh/rSQSB2mmtybYi5ZSE8aQqOyLpl8huCxaH7gXmAfcNecjguPli6V9opTfRZqvBd/0AmEN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5ed414-8242-4bb5-3cee-08d7948dcfca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 22:55:09.7569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/8eyyx3UvViFN99yjHRr5EyF8JGGSAdllHdjoSRDVZ4Mapi+XdPrFmVftuCQL1liFn/dmxwHCWsPF8HxS1sig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 1 & 3 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Patch 2 is
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2020-01-08 5:49 p.m., Alex Deucher wrote:
> It won't get used unless the driver allows the gtt domain for
> display buffers which is controlled elsewhere.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fdf4d202ea1f..d0c9a5725813 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -910,6 +910,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	case CHIP_CARRIZO:
>  	case CHIP_STONEY:
>  	case CHIP_RAVEN:
> +	case CHIP_RENOIR:
>  		init_data.flags.gpu_vm_support = true;
>  		break;
>  	default:
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
