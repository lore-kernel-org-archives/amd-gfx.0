Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50857C001DB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 14:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C534510E204;
	Mon, 14 Aug 2023 14:30:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F20F10E204
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 14:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTGYCQ5ritm5NbwGmu0i2jwcUjtLnzWo1h6moh5FQOLKrQ6VLtpZGdeG43FFvi+4izQtXx7sJd0E7ko7AsRULbeqok7Nhv/95HGfeYz6tqv4LX3uPwTYV3g47kDr4WfbfGl62EQIm7nRF3jF/TvygCWMDsOVlLhwpe2u8845q7NrHlyVwmKePGzYL+2PbZuaClzlOc2WCZlozxFtv0G/rf4PBL8+tVW9T3nlYyQmI1HFyyHynMvgZUr2y/7QGWHAAn5xVv76L4zfFoiy/3XrZBtUmzfY0WQEgmVdtUtR002MK9knJcbk2pu1SGMx3pn5GMAa5E9U0rEhi0bkJLlVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkYxHPGyZ/9G1nRND9FrO4WsJKf8Bm/myCi5/F5P09k=;
 b=chSsFNSQAidPESQuqHHqrE3TekNzDdVDFRIz7zffKUgynqAk6yR0jq5M30QE/MDaPayqG5qpguQ1GPXqTZ8vp37HDTmi6eeHY+/kt2M88ppY5XOj5wRhhu4oDp0MEU5eD1kRv5J6AwWTyuLceEqpJke8vUlL8vGWmCFgakRo7LSSkt8sBOS8m1k13Rt6nq95MbWTfZVG/YDbdzChf9scJDT0MSZ09S0ETQzoMYmlN29lFqwi4y7rQvjbfDdkG8MLUPDmzd9G3lQPavxtvsF1wd94KHnfP4Az0QCY0IzRcaG3H6BhrUojUGq5om85KIta/Tij6IaIhjJQuYauiQdAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkYxHPGyZ/9G1nRND9FrO4WsJKf8Bm/myCi5/F5P09k=;
 b=Xc76gTzmuph1x4aUDn6IrIOaomAIS10/gv3AWdE1EG5nCx7juOFwRqT99/9uSZDZL8Nli2oifozEONrVUYNk+aPvDdK5Jy6YsONrCipuSukhHf4v7lltO3JHetzox84fHgMbKDgIaYTJegrTDh+KaSkvnZu1Z+LKfRmscSGVWS4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:30:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 14:30:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove gfxoff check in GFX v9.4.3
Thread-Topic: [PATCH] drm/amdgpu: Remove gfxoff check in GFX v9.4.3
Thread-Index: AQHZzruHAwGQtFJk80KcfwGG0hsf+K/p2iXw
Date: Mon, 14 Aug 2023 14:30:22 +0000
Message-ID: <BN9PR12MB5257B32B3CE87AFEA4B04ACAFC17A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230814142735.677239-1-lijo.lazar@amd.com>
In-Reply-To: <20230814142735.677239-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90bffd0e-70dc-4429-8829-924401f14d17;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-14T14:29:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7380:EE_
x-ms-office365-filtering-correlation-id: 436ce296-a2d2-4316-ffc9-08db9cd2fe27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoB0YAZ8MFkdDohyPY1QQ793GQPsTOSfZxBNkyuACihMLQ5aq9QCKYxyPzUA9KhA62YTq+tkFDebPoMaoaxsYuc9Mrv+ud8BcDQQ42d0fBf/n8Q8UDzlO+SUsECA3OkLtu8P9n440b/3tCsOB1s84RCa4zcT4fsqDlP4zaHD2y6qqAdnUpGFwqxFSWn5v73VQ6C9n8gqK8JiBX3nNtMihonEks0NMtHTR3je4uXjl0cYVqe3q7AImpDmGoEyhQLWN+rokC4zmv4+76GzeO6R1ksLDw6IMBqv2KEGZuyGGUD0LSIl8NsjsygBE8wKg1mM86mDAg6GxtZvQk/bBhDpV+MMqoZg0ju2+I9qb7O5KHe5tMowCAv4rqSPKmtu+02W+2a+vDJrKShTEbpM121WXzrDOf7F6/dWhwQp9bhAzKg2l3gAk8LtWT6efU2xbTwmWtgfY5nB98fDYnMTYcXzJ1qCI403qf2qZfTuyK6oxc5cxj0aJOnCdKawQz4KELhEMZfq6OjkyK2TMYjuUvnjVzhJ0og5gGaqOL3Ihj2sDhXv9EB5RkWeoYbQ/UoJuc9l+3tOPbECR7X/0snV1k2bass78e2f3TbnsDNr9Hu71r8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799006)(451199021)(186006)(55016003)(5660300002)(52536014)(26005)(83380400001)(2906002)(71200400001)(478600001)(41300700001)(7696005)(6506007)(53546011)(8676002)(8936002)(4326008)(9686003)(76116006)(110136005)(316002)(66476007)(66556008)(66946007)(66446008)(64756008)(33656002)(86362001)(38070700005)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZakJfhnJxZezzbSK/subUbIwHka4iE3g03LmBmjssHJ6LhLHVQ57WwCqkaX3?=
 =?us-ascii?Q?8IQxHkVwd4WHfU+tQGimlfwgy4NP1rJ5KHrLy34I7UHJFKHSjgG6X3JBm25Z?=
 =?us-ascii?Q?Sh6w2brEz/lqRpzStl6BurEmP8yjzXUlMXDBrFF0NvHST2hVN2C3g+zt4q56?=
 =?us-ascii?Q?wnmO9bmchw3ptGjKdB6/tqEfKNq5StOAsWyL6HSr9PcwlKuVyhsl9D0p6Fun?=
 =?us-ascii?Q?JJZmo0snuly7XxTQIonyhZYL4+jOBuONSjKE47As50odh+w5ypICDyLrt74Z?=
 =?us-ascii?Q?wx5SD0T2+dnVK4da9jwojT/lCWV4BNI87NwWwtE+9B+ETbpY6uPO1hLnLyDa?=
 =?us-ascii?Q?nDCS6VxvTAYo4b4TL5S70/d2lMPjmXOOoZ8z+eTjal0fG/jyH3Ltjrwj5pEF?=
 =?us-ascii?Q?xkQ1sd7BRJRMXkTkHEPHKm98cnx+efDSPd+u5EY6O6amAGQrrFl8kQX9AJns?=
 =?us-ascii?Q?kJlXF14oWBQhHW/TF7YlQXyHlQF91+2oJN3M5jsx98GO/10jXBbqjLDRhDt0?=
 =?us-ascii?Q?si0Lk/Z6jjH1BjMr38Uk1IWNJ3idCoaiSh1mwXdFSRLFr/Ttdsx9JJoo/rrL?=
 =?us-ascii?Q?mF97DrO0daZFvEvVuKLttsa6lzHrMp5xHXbS2yW8TQ3JBOcWmFal8eatlgNo?=
 =?us-ascii?Q?Yg3WjWc0mWbH+dG93ayxVwdkn2oNpekJrvlPX1kAy7vi5KL9SanGas0tpas6?=
 =?us-ascii?Q?gzKNA1KDx/pvGkU9xGXQePdLCadKY6/RuKsKVvlEkrORzwy7oTI11WJtN6k6?=
 =?us-ascii?Q?V7MyXnqpbrD2SD/W4Jf+UOQWgjysGikDLaSQb9qnFwPaCBqYlILKUM6kDE1r?=
 =?us-ascii?Q?IZFrDDmiqYeQt1EoFPbv49hkch3w8BAsBFblgczT6sF3iMS2pZ9uXIGgkatC?=
 =?us-ascii?Q?U5y9+oDUM42sBnasENwj7pJcKoMJQwjTRdChMbLGNemCocSeWzLP+fnLTFbX?=
 =?us-ascii?Q?cr+/2g9vdDH6o2Gxi44avYAAiG2nnNNb6MKQvBfKbA3TGgTQHLeJEXZyp2QQ?=
 =?us-ascii?Q?1Wc14ObL0PcYOgdFuZ/GcHGXkKoxzG7knwk9a20W6hgJF3Dwx9CIA0bqg5IM?=
 =?us-ascii?Q?N/135OpS0SJtUkEqWUEArv+GSQSBufeCN6FXpuqnf9ClaT40OIe0xj1Jv32Z?=
 =?us-ascii?Q?lrptW6DJnF5FuDD3HejMUTUOoG6L/kxgLXkcP5FzbqlPlMlCFOdV7jSvQSLS?=
 =?us-ascii?Q?56rq+CFF4JogctZA0KtgNe0Qme6wdsWvyE8nLEWjl0Ro0QfSsi3Ili95AOkJ?=
 =?us-ascii?Q?ACr7yRkyGOwAQFns7o8j3lSbkjIEMnKn6wGY0srcR92eKEWEeKfSDiYmCJjn?=
 =?us-ascii?Q?A6ZFp8d2r22JnfNM82fnCDEbXXKpoa8TGf7JSvCGtIosdFtFif/DcasKssu/?=
 =?us-ascii?Q?jIq2cgOCQ9Mu61jlGborn+SOUz+uGuVeeR2w1lbzQzp3C/tOgOK+pKtdwtTg?=
 =?us-ascii?Q?wPzDdnruUOgyrjJTiKSimYuEoNtOJDguOIzCxSQCKBuVsUfDHZJlCeEJ2phu?=
 =?us-ascii?Q?sw0kMU6Z/ujR4RFKPGL/cvBlo5WCxxsHu3JLzNIrRZnbsfj925LZX+ErKqnG?=
 =?us-ascii?Q?O//tKkJTwjSjrgRpFuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436ce296-a2d2-4316-ffc9-08db9cd2fe27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 14:30:22.3745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9rq4OKsCFdkXIl5Z5eNFE7RI81mgvIhCZcE27sPbTrBAs4mwhb/Wr8sTSY90UvnZhcpM51hWW8rxEhRhyiWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, August 14, 2023 22:28
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove gfxoff check in GFX v9.4.3

GFXOFF feature is not there for GFX 9.4.3 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 564770c3875e..4bbe9c5ed87f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -337,13 +337,11 @@ static uint64_t gfx_v9_4_3_get_gpu_clock_counter(stru=
ct amdgpu_device *adev)  {
        uint64_t clock;

-       amdgpu_gfx_off_ctrl(adev, false);
        mutex_lock(&adev->gfx.gpu_clock_mutex);
        WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1=
);
        clock =3D (uint64_t)RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPU_CL=
OCK_COUNT_LSB) |
                ((uint64_t)RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPU_CLO=
CK_COUNT_MSB) << 32ULL);
        mutex_unlock(&adev->gfx.gpu_clock_mutex);
-       amdgpu_gfx_off_ctrl(adev, true);

        return clock;
 }
--
2.25.1

