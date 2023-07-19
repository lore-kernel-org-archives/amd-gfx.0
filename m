Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFFEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 09:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557A510E443;
	Wed, 19 Jul 2023 09:12:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CFE10E443
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 09:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcfYtgyK6QNovIi3/xD9sh8NBGMUWPEIhSwF6QK29A3G4p4lTC+eKuS/1IGeoa7X7FPW2PxzLJLXfdfXxlagj2QN3tJ5ZsCqwCPwNCFAvQOKmgSlmcnmnOwF2/nvFKcw2G+u3O3TCVq0EtqB2kORRwnvhEHSmwZqe+h8SpooLysz0TvktzmjmOPMlH0XdCEK0+/CemAM6HDcEJBxt3/ZdJigRmYOljS2UzjNHBUsLkvEn7t7wexVqMjGzOZ6f6Thf1+mATa6lP03Nuol4OuBjdMkPRUxCNkZgo1DtEfaL1c8pARHa66K+nNiVuC9LrXNUO5rptZLWHqr3IHZ/G4eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILcRnHxmb+iaFl/N2xBaCrp0mvqJ/Tq5BnR5AgMjBg0=;
 b=SMmt65HJGGZ2X+i20esfpyaMoVAo4OIbIrGYef8+i2wDlvF0Nt5H0sFs4ViD9GkDoNZ+SPAAJqTQnQd3lIxXKqNohzLj1Xf71x5JqpAB6pFn1mAnACuuZhCK2qvCN/Sl7IkV0kOG1kCB0b6ZRneEIs5Cvs4EssAoc/dG2bVdpEAeeQbpusWox1KxRbRNf5wENmlh7FvxjIuuLap23Y9GpjU48bAOduUPgLk03iDvxOi4Fn35AzkECn1sRCAZqN9kIffW8k52IGR976REznLwYu7RWEkFeHKUGPlbcBeFAKYxM7odpoRWLv3AXoMq9u6gxNc44UKtDe2Trwa/enPriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILcRnHxmb+iaFl/N2xBaCrp0mvqJ/Tq5BnR5AgMjBg0=;
 b=swZZoNrBNcqVupRhMXqZT7hAAG4bQ0nCVU2KYNACopHTTsTKoVOdrF1/JOjEUhx0EM+3xUfti02rV4dgerqKEr3ROx66r467jM5kB13TkuNRygH4fGM1wc1LLJFIbZLB08SuGuUaNlPm9HDCGtjPJp7b0kFi2yO2T+x+fKc4ShY=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 09:12:45 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::8436:d976:9c39:a6c4]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::8436:d976:9c39:a6c4%2]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 09:12:45 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix infinite loop in
 gfxhub_v1_2_xcc_gart_enable
Thread-Topic: [PATCH] drm/amdgpu: Fix infinite loop in
 gfxhub_v1_2_xcc_gart_enable
Thread-Index: AQHZuapzP1VkisMbC0K20WgVYj+lxa/Ay8MA
Date: Wed, 19 Jul 2023 09:12:44 +0000
Message-ID: <CO6PR12MB53941C48B4DABBD0EF97ED689439A@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20230718190219.320278-1-victorchengchi.lu@amd.com>
In-Reply-To: <20230718190219.320278-1-victorchengchi.lu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6a49c06-7485-4ce7-a73c-12ec510f6d1b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-19T09:01:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|CY5PR12MB6623:EE_
x-ms-office365-filtering-correlation-id: 174c8359-b350-4ca7-be38-08db88385032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtcuhcRfPY3JT0vgRsvs+HW4V1+hDKyv3TwArtnNaxZthni/ULmOHnvcP8d/mfHJISOj4UOFQWHGxUjCp/m0SGrlCHFhR+WG+uoSeCjpgFIQOIGHu/0BYDOHOFgGSWQeoiaOlt982yl5JyLx2QxWTjAyOY+HjGiSPILBYjZqOjQYXilBskaHO5LzhY6AuHHmBQZ850sFmYggFkcjYGz6O/5Vwv7wDJjKiho/A7tPzSZz3viD9+NNL0N1IHF3bDP4IqgMSbE+I63uqqZou4YSX8Sgi41rP61MptZzNz1MfN5/lP4/Z0pZGYtDS3qJe5/Rsp8qeXa+2xiXxnvso3Xoqt0Iisrd6X7HZb6Ol+gqqqUJ1PL3BHnta6fXO2f46ZfRYA3R9KH4PtczizU2zNtOP2Ui6ctP790cfWqdh/BLQ4v71/zaFW0WBsXVW0Mmq7j/+D9NooeQhN3LIZKLw96RLgRNoYylcee0ksmorHSpIek2ltc7yf/a+8caVgiiImABamJfQQF6BYSFru+/dZ+E4g5urZCocp4OZQygSR1IqYZt6Vh+/10YYEpTaaLMDPtjqOJoeIgOptxt85lrqJ3wPJaNTPYkXHRV2m6EdxOBNJty6IwZBPd9JcAGiYlcTSm8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(2906002)(41300700001)(316002)(52536014)(5660300002)(8676002)(38070700005)(86362001)(8936002)(33656002)(55016003)(9686003)(26005)(53546011)(6506007)(478600001)(7696005)(71200400001)(83380400001)(186003)(38100700002)(122000001)(4326008)(76116006)(66446008)(66476007)(66556008)(64756008)(110136005)(66946007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ssApKM2PcyXDtP9r/5iYbnigKVukyQ00oS0QpYNVW9VcCtXdnRBQ3xNEhmIT?=
 =?us-ascii?Q?CmZ6vG9cEXgZSm3nRJn07p9Qxg1dov55k1vGtjyaRx9MzRujD/ZXKHZIqydq?=
 =?us-ascii?Q?be6ZuqXnOJUR5WRGPskwiWH0ABkxu6lAs5+DuxwPgzAGMkvSOdjZPe7qOGxo?=
 =?us-ascii?Q?RpuOUl44GAjZMV+NRlAeBDDRmJNwGZeY2peUVEJoLb7sPUMQr5xBNdwrhtbN?=
 =?us-ascii?Q?FtJTf3kxKUKRRShqZVGdeX9mXIU7bhtkMuMF0X62l5aGFl2K3gYF5sSEnyUZ?=
 =?us-ascii?Q?Uy1ka8b5tN4+vcrhqjtBsrhPTl59Xqu6u3qwMDZ02KYscfFdrzJMNhYIJs7O?=
 =?us-ascii?Q?e7VoyYECxN4CaQ/w08f9h5VMg1UtNVQA1DRajv0e6rnX3QbmYAtsZzVSYnJr?=
 =?us-ascii?Q?oD4tVwjXtYzGB1Wy3cFOMniwwMy1yhyGgAEwoU9r0n2cK/wnnJN/rDW0DDW0?=
 =?us-ascii?Q?S4y0i9MbtRxwjzhdcF+J+iWfdC4xn+nKkj69mIxaUXAYxnrBgdOv5fwMpwcm?=
 =?us-ascii?Q?EnX05PBZgksfz0o4ZeTNzoLlIzymwNY8D4G37YzR8dd5X2v6c8Lu11BuaeCb?=
 =?us-ascii?Q?A7YD5kT0I18fBfeHp9HyOUwkyy6edp7xIqaqmq3z7oKAgBv9rQIKqN+8zfUt?=
 =?us-ascii?Q?B7LWN6rqCKkHFpQLkyyZ3QTbWRiavrBveBWi20xpbULqmAp7XP/CHl7nHLU1?=
 =?us-ascii?Q?RPeaBEe4grQwlHDh714JVTmU3Fe9cnRlZau7ZDCjGC8+kTcmAlLZa/EecO1C?=
 =?us-ascii?Q?psMNWK4spBRy6u94+2wIPQQgEvnjwdD0j5DEdsoplz5slb+NVQvF4rf0d/uQ?=
 =?us-ascii?Q?H9xjtjm8uv8qSFfy8f8xb3GmfIOVX3Et6LrPa1o6DQxdle1dZHryik9DaIS4?=
 =?us-ascii?Q?VUGiWTpDuKN8kHgnS29a9AfmDJFc4c4dvdBfShOxzX8e69OSXvIwnRrNW9At?=
 =?us-ascii?Q?C96mW+sDbsMSXRjI1LMdTd/1drUmnvypcLryMRQgmBFOopm6z8MquvDDFwKY?=
 =?us-ascii?Q?P2vXJ2Ukrwbc5DfLNXCKHfNelqzC83YB6IgFR8BcmIJnJo9+lpef9YtvzzXU?=
 =?us-ascii?Q?C/MwstjEEksaXmsNyS+BrO+CWUfoSvjWlcu10WbO4Ur+wDMyuXm4VnLm8ar9?=
 =?us-ascii?Q?IgU3CclR3hUZpet2/a2MsOvwS3rDkEgy+obFgD3xiDZ52z7XCHLrvEz7Y332?=
 =?us-ascii?Q?MVlUpNBxt54exE447aO3t2WvSY0f5msw74IZHCN8Sys+BD/VbFWhWy0UJ9IE?=
 =?us-ascii?Q?rVnpiwGrHoO6IC/KwZYEmrCJrjWroaa+arcC7vHPq+KhY1MonAQmx3jUQJ7Z?=
 =?us-ascii?Q?KdTJR5r5Oh8CATwPkzGxHe9RJ+qE8KGmaoPKqt0P466EoPoJPN/gSbXTlGbf?=
 =?us-ascii?Q?B9HKAT4o/wcIDY6rRl46Ty/oK1CGQHbaGEgIhLRuDZqdKBGK7RE6r52Dv0up?=
 =?us-ascii?Q?m6/lTmaQsc0W3V4y7l/BsIS9IdAGxcRVqC+mP+Z3QvPmUfX8daekPfTGf20X?=
 =?us-ascii?Q?AwO23pZkGTZOBbuKX3QLhIyAfbGDJQ/ssUzE8tqy/+92+jY4MpuyLiSMSTSu?=
 =?us-ascii?Q?Y102bL11DUY9c2Eyeco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174c8359-b350-4ca7-be38-08db88385032
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 09:12:44.7748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbpGR/M4gl35Kq1t7V9XxQja6RIoODZwpCCZNMIRmi0y7sAQZRRf/qGYKiQQ9VBob1dAfB0ycLhOe/Qj60daag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Lu,
 Victor Cheng Chi \(Victor\)" <VictorChengChi.Lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The variable tmp_mask also could be removed.

Regards,
Bob

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor L=
u
Sent: Wednesday, July 19, 2023 3:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Skvortsov, Victor <Victor.Skvortsov@a=
md.com>; Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix infinite loop in gfxhub_v1_2_xcc_gart_enab=
le

An instance of for_each_inst() was not changed to match its new behaviour a=
nd is causing a loop.

Fixes: 50c1d81d6365 ("drm/amdgpu: Modify for_each_inst macro")
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 47f95ec218a3..b74df0e9fb08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -413,7 +413,6 @@ static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_de=
vice *adev,
         */
        if (amdgpu_sriov_vf(adev)) {
                for_each_inst(i, tmp_mask) {
-                       i =3D ffs(tmp_mask) - 1;
                        WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_L=
OCATION_BASE,
                                     adev->gmc.vram_start >> 24);
                        WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_L=
OCATION_TOP,
--
2.34.1

