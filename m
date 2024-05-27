Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39508C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 07:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCD110E082;
	Mon, 27 May 2024 07:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qvDR0XJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B47810E082
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 07:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+VCvcTb0D5Giu0ZDwrRkkX5OjoalaPWJikE75CnCtcibBNsHNJOL4s+P7XIBOR06q79xSJck7uARzU0VZ+alG9u/fdYCXPrnK3GgpgNgCKv/kaesVNzuyQX21XBJNHi34R+6/W2L/e5TgZ2IvNPRh8YbwAMQt5cfD9QeaYfU0aqmRgmahURKpd6i4XUdlGks+cOXDNYFj2arAj5uPAmZOAzOsEW5YT3D3TZ0hmzq9EJhYB8Nz35ZhyOEJGJtw8QAd2JArcp0fqwAj0ViSlg6iuSIs97xSNyCzC+5UtoyXJv+21QhBR4Ccx7ushTPPdS8/OBZrZoKJwUL7OYDZRYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9bIxvoN6b2tk91mbaz2pPjaNu2DaCyyvxhjJqD29zs=;
 b=IkW0mT8ra1SqNWFRUa20JOd4YgDyp0LMXcaBDvVojKsRE6nZW0XmAnCtzM99wiy7VvphMzcg+CVUwqKywQKTNP5Y/0TfbswOX/SNwmNfaZhzbSDfmsBnjN7BDvz4qXWG5m88+6MOocKSFjHg/HEiRRy2dzyS8TQ5y35bCbjyKRKLgJ2TvPSjPEUtp4dGWAjDTxR3ulS1ujmZBTEiAuzG0SPL4sWFD5+8siEJ4hbBkxcXMrFaikzy0P2rzfB5lm3MfH0JhT7oB9XBR2Ys0uVUX4bqxLVgtvnQdkeqUjxkgAZlCx4jG2Eq01QUhVh5lzUKwO2H8ZRWsVYpOB0irjGW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9bIxvoN6b2tk91mbaz2pPjaNu2DaCyyvxhjJqD29zs=;
 b=3qvDR0XJ8YKG2/ScC0Cbgfqb6Dzv0q9nTKK5UIsBbRLQANzukXV6xc/3PBdu7C1+yTJMQdpy3fzTOyWIV9RK6uQmB09QHRZ08txyW7VuOV44lZqVlxKy2uNnPRLUeFPsAY3EztDrBs/Od/nT0oaPnUFoDRWwfp3WZI7o2OXN9mQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:48:21 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:48:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix typo in amdgpu_ras_aca_sysfs_read()
 function
Thread-Topic: [PATCH] drm/amdgpu: fix typo in amdgpu_ras_aca_sysfs_read()
 function
Thread-Index: AQHasAoHfVN8gKrD9UuCuzvyM1WhgbGqtFUQ
Date: Mon, 27 May 2024 07:48:21 +0000
Message-ID: <PH7PR12MB8796E5EA04A677E0FEAEF122B0F02@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240527074630.284169-1-kevinyang.wang@amd.com>
In-Reply-To: <20240527074630.284169-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a93ca560-2e90-4db3-9a6d-7ec674799192;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-27T07:48:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH8PR12MB6819:EE_
x-ms-office365-filtering-correlation-id: f7fe0433-99fc-409f-2fd4-08dc7e21619f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?j63qNt3Y0UyH0SMUu7yJEZAAMgO44YDWDRQqmMP40pAPH0JOSFqADsy/CW58?=
 =?us-ascii?Q?vobjplP3tfKLMeqASkkwG7QCNuOhdmSCzRlYJh7Vo+8g30hSXfpi4koNakBU?=
 =?us-ascii?Q?78ke2RHOmdHVWh77/GFWcfd6nixDu6JiYcbr5O9EsxfytcEM1Id1e228jVPl?=
 =?us-ascii?Q?sepJDrfE2bGZ3KA096sS81Ea4YeCudiRuEprBjyGS21q4VaK6R3zKz3zDggi?=
 =?us-ascii?Q?mpPGeHr8AESz+Mv2s9osiaKHui2GEOdLYekMiNQDey7p5rBIlrJDo05JmeoH?=
 =?us-ascii?Q?jmzQqgBXHj88YzS3imAmBduw+9eMZmhH6rDnsnEYt75XC/+01UHjabwayjXI?=
 =?us-ascii?Q?BZAN8lKdnq+hRmZvgvSQMnPJrp4wwJJJU8qZ1REYEPiLe05eW+mJkXEjzSqq?=
 =?us-ascii?Q?mzuGxhgwOjUhtRsqBOoRSF1QbrVnfxkfMD4QpmjZH8JMBHQ9qkLOTrl3T9Co?=
 =?us-ascii?Q?fXEWlwzkyqrliClbmuYVg3QjuvGyjgaGrbfF5SEXelPq4duQKfmxyHSegVzV?=
 =?us-ascii?Q?NcumW44R4mJWgP500f7o/VHAHe1HMZyZsxj5vTEbbEMEhLZwRd0+L6Uy9m1C?=
 =?us-ascii?Q?N3weY65hnhCnnNfcMtt7BOLF8qIDyL0xKyaHQdA1ksEazkgx9WgiQV9YkEMy?=
 =?us-ascii?Q?0JsL/VSWcB2Io01ZM995UW0qCGxod8X9Wy4ZGil7lkJ0mqO5rh4Y+ynOdnpF?=
 =?us-ascii?Q?9QUx1lBgUTIbaRvZUSDiPkAs7VL9pnEudWO87Sy/w6NPrjCcp2qerBXk5IqQ?=
 =?us-ascii?Q?4smpq7tJlebBWeqcgLz9S0bMK3zjCcIr+dL2mj8kL+8c+23i62j8Ey98EfbJ?=
 =?us-ascii?Q?pqMji9r28OSC4urZUmlh3JixICarOWQtyWyOoUjKQYgWvK4XzWQrcJIz36JO?=
 =?us-ascii?Q?1HpSYaHg4iZe+BhnhduZUc4yY3c562Me5BgJCWGY294H/VvIwpgdXJB8+V77?=
 =?us-ascii?Q?fa1IoWEzWCpL2f5ESUJurWA/g2GeJSrYB0mwyT09ZBFIIp4mWlqDZBMqFHK9?=
 =?us-ascii?Q?ehIh6ae0tBVXUTb8J2mFShbl868rhJcvzq0jTInsgkwdO1J5DVURxaqhWa8C?=
 =?us-ascii?Q?7zb1iL+Q9u0XOmJv9Wm++QI+sE9Od6BFP4BXgzxCl1DGiLIbKbf0O2FJUd8P?=
 =?us-ascii?Q?gHkKzGezFtjzkKNUrhkHqX0zeskntVH8uKw56FehKd3KfnDgvomD8EoK6fwK?=
 =?us-ascii?Q?P4NhNOfvmLqs6bgNjaq7+jfqC/q7gOMvXAJXxgNlosm/9mziv6KiZ7y0Fc9W?=
 =?us-ascii?Q?FVPP+h0CuWuPEKpmX9C40jFg0Q7d1r3U1blYwThkWsfcTMak/JGzxsx64586?=
 =?us-ascii?Q?ZPwQTXdDiPnUGY+CK9PotaFMsCk36WKiJhmabozS8daezw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MIxiLPBtdpnF/kj6U6mGX/uTE2W2EwnLVpu+EmWstGpjqX0k4W15Zo+ftsV5?=
 =?us-ascii?Q?cXuDBCDaKluZ1eSbRZXoGTS6KnUmWiX2remIUGf6hwjS1jgLhXQkFFxfyj23?=
 =?us-ascii?Q?Ln/VCcvMSjYo3cw+D+9XxOy26Tg5vzpqBxGPjiG0y2JTCiNPbZ5kDiXN2l5Q?=
 =?us-ascii?Q?ba5q6oZU8qKO9NbHkx01qum803tB3epN2wMwGQoYTYVNAxLGJAO0NH3DRi/H?=
 =?us-ascii?Q?XR1IwReFbpd+whkwUgEWCL7Ordlgef6lAA/kAHemyov1lf3qJQ+NzLh7ULFr?=
 =?us-ascii?Q?Tt8F3MMvIX0t8fR0iKEgBR6qzSJl12ubv2Jp9jF+Hpb8K0d8EF7qRyZiZ8D0?=
 =?us-ascii?Q?gq+jDEIoV8sHY8R5+njK85MAEyaK0z9fblKY2FW7RKjPqMLJGfA9Fb7HIKJF?=
 =?us-ascii?Q?ag+LFwz0cgoo4UI+nAaq1Sw0KkoGnChWupWkIchzUJvp+U9UUQRoOZKDrMhE?=
 =?us-ascii?Q?7y2axp2Z/kKOGUKrjKSrP/XBxW14A2OVXJlvMueJT8/yZq9esBCe3gQFXqCB?=
 =?us-ascii?Q?QazCZMVShcH8ucO+a7qVk2OLRict/GqFeIxo9gDQHzgQ/2A1fgEVphKII8CP?=
 =?us-ascii?Q?RIuAnL5oLzAD3RoM9myrx7vS/E/pTgeOrpvJuRSF8R+pJ7C3EhUiTVC2pSKx?=
 =?us-ascii?Q?HKu26Y1d4lWfZz6c3SqddW+d4ll3pHKnPNnw8ee6g6tEVEy5hQj4r7xtV/Al?=
 =?us-ascii?Q?B2TyoXOB1UaaR2AUca5QjG0FuDZtBceKNe55c0huuEY0l7yLTEHeGvl/OjN4?=
 =?us-ascii?Q?SpMy65g0BK0OHMhVPIQn64mDtOvcNPaoaJX7W04QCfC/E/QQTwKwJV/MJA41?=
 =?us-ascii?Q?mqO4ZqTs5Nba3CYbJsTUjElzV+krZ3fgdjYUbin0A0JghqRZN2tlJsodFa30?=
 =?us-ascii?Q?NNWX9RQK+dVhphG56uur0E4MzmSaWCYwdXwXwhBXdchkNg+4UxTlNR7QH43F?=
 =?us-ascii?Q?7sCmkjLK4ytvEElsllCZjsY/mevh9R6pfVxlzH0cctZTBlInEpEqxAgBPIcZ?=
 =?us-ascii?Q?rZ4GvLwAv1v+QxIhSCa3Rrll5cpp/POXsIlPxF6xOt8M1Fzr3ESbLpamPE5r?=
 =?us-ascii?Q?cAvGQvDU0mHQvRfNK/eScIJorYQOmdECwmxyYQ9maWP24fI4DdDEcPVfAus0?=
 =?us-ascii?Q?GHWY/D7Au/LxNsqbocUmc5JhxhdDZqpvUW7ejphw3pqjWo+N8c00gDlCJORR?=
 =?us-ascii?Q?2K7e9TO1GjEtX8Per3rRe6wCtBi6DyIufWUqxP5p+I+urnPxP/pEfdGjD2W3?=
 =?us-ascii?Q?My9wB4mNJ/SnofejSz9UBkZR0Q8QxWOg1NELJNx3lhjZxIDsberjm90qBc9I?=
 =?us-ascii?Q?tjdkMSZG6HZuw4TX5vB7lVBwoWT/OO0I0yeo36aSOMi6xsi71D6VeX21A8n/?=
 =?us-ascii?Q?8b9/ofkbzK45im77KhvyixA6jknw35hA397Sdbs5v1kCnVqyElFCnofswtfa?=
 =?us-ascii?Q?LiFHvT6c5Ds8ekj2oTMpRfBoEK0tyZIZ9XZ4C/6gjYpqdV5+fvh8IYmpm/wm?=
 =?us-ascii?Q?9rONnEKBBv7bJyc34lO6jYyQ784S6CW+VbL8/kQUWFCIO9GA9611er1SmuwG?=
 =?us-ascii?Q?cCQpjqjMqamTXUva6sw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fe0433-99fc-409f-2fd4-08dc7e21619f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:48:21.6489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpcF0fy6JXFyWSSn5hC193VNye7aD9i91mJYw+NhQwopQPRKqvFvpQQOH3S2ckp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Monday, May 27, 2024 3:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: fix typo in amdgpu_ras_aca_sysfs_read() func=
tion
>
> fix typo "info.ue_count" in amdgpu_ras_aca_sysfs_read() function.
>
> Fixes: edd67b5417f5 ("drm/amdgpu: add aca deferred error type support")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8073716bc5ac..db4a811cc0f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1299,7 +1299,7 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device
> *dev, struct device_attribute *a
>               return -EINVAL;
>
>       return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue",
> info.ue_count,
> -                       "ce", info.ce_count, "de", info.ue_count);
> +                       "ce", info.ce_count, "de", info.de_count);
>  }
>
>  static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *ad=
ev,
> --
> 2.34.1

