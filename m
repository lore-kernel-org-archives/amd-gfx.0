Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 17:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BC310E6F0;
	Mon, 28 Mar 2022 17:09:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D9510E6F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 17:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRF0dYzPRQozvKkL1twd0TyiUeXttF0rPhANBh8RF1NICGiJvCBW/cuggHAmPjIw3SBdpkYIHZZWk6pHUL+BmxhD6VCf+6TnfVqeA+K/7PsfIjp7vQtZ9vl96bBPjz/oGpsDh3vZKN/fn7nbt7OXoc2xT1dDk5w9ZKoiX0R6jJI9XvKkYcP/cn1LQ0b9UxlUffOHurnFYFSrB5e7HC0fI0PjNwFhLrcnAjTAr+MdDHN+YPB4OUBwshhv/rihbKWE9KHCydjZjyeZEJQnXFBD4wsYe+FXd/+LQslEzfiCmrA+uSwr2RwkMX8jxNWsHUACMnsmiRHc9M+hmjOmO3mAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVitI7uoCE5q3mC4Dsl3QBez2XZ6Af1D/UrLJpnUxnM=;
 b=Pt4xntebHtSJ5E+ywuYonIjxvHGT18Bg0CU4S/Brmrxx1HHPttjpwyyWVsOS9Qrq+wQfdxfCmFmimOOGqMNYABxIAnY6GfnMEfblUbTafaZlux3RRw2O1Cjq7qfKZJ6VtgWlWinSAIncHW1V3Ebomj7ADOdsloYdSpJIJ5B1Zx/5+UycRMLI1CR8t/mmxryo8TvPX0Vhd5F2e3PA05AFbZpx9dzYaK//cjqeyiLo1+qn6V1OiUxflUzx4IDoLSgmO1zV8pFWdEZ0KkfmtvKAAMJApgCEH0JmxBFt6RwVmZyV1yHyoKVAGlZjWx4TKLwNUoS6fvUZfZulA4f7O56M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVitI7uoCE5q3mC4Dsl3QBez2XZ6Af1D/UrLJpnUxnM=;
 b=e19BMiU/62SRvAdMhYwUVl+8JKmMaA7cb9iPxgJq46tOQ6U/260K9BzMb9S/f7GsE/SlQrW7HJ4kepi6FfahkgznYMWyRDUoMKL3alKnfC3tENYuOoVRVK6bozN0G3GYCnoBQyIC60LJlQsrkhN2epQ4m6N2b6orVBVVrdagQxA=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 17:09:11 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::fcad:40eb:12c8:977e]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::fcad:40eb:12c8:977e%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 17:09:11 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 5/5] umr: Completion: update new format options
Thread-Topic: [PATCH 5/5] umr: Completion: update new format options
Thread-Index: AQHYQcdgZ3PHYwdXFUm6sWa5V+v20azVCXlb
Date: Mon, 28 Mar 2022 17:09:11 +0000
Message-ID: <DM6PR12MB3547FF2E82BAB4CBA3C315A3F71D9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220327104214.106340-1-luben.tuikov@amd.com>
 <20220327104214.106340-5-luben.tuikov@amd.com>
In-Reply-To: <20220327104214.106340-5-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T17:09:11.048Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: d7acabf3-6810-08dc-e84e-dab031957648
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4e46f06-d11a-4fad-a167-08da10ddaddd
x-ms-traffictypediagnostic: DM8PR12MB5462:EE_
x-microsoft-antispam-prvs: <DM8PR12MB5462BA00E3450CA7BC2B5616F71D9@DM8PR12MB5462.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZAXtsztH5hj66ldmQvEnrr/GRwId6cWgWDdSjyV/CScsirrJCYUrCmR4TRfoIpTymMURKfKKxVYMUTUl6rulzSCQLiovQHyfzvwygGBIFFtByMWpzOMiy4TwpGL7Kilil5xzCMWYrWx3Sg3fCdD3cNqfnTbFbF3ZDM4jlMwVC+SHofTmCz4MrJKSJ28u9quLAVVYLF8vjSFzv46Rk7kaJlcLYRoSr4iNfuXW55/FcwT/uT/KpCuY2Ev8LReJ/LJ+EWI+0bU8O+3otJyHlvHJ26fpKlNLrCWV1WO1zdTrhBK/HsR/WT33IWazfF/3u7b3fgz9VSVKN335DLOgvF3r58+QEbitAGez5K2zuf4vH2f7E6ijsBwsYr5Npt39xGAIV2VWfXcYLT2vI/5JtFZ647QssAwKgp9KFzThkvkNDTkQ7iBAP8uK96QICYly5X08Yfg2iaxhyu6TyMwP1tbEEOIRevN0JMywXNlmnqRVeLBgBnLSxT4nKruUT1Afa8oUTIOfS82Ub6E7I1bRgkRfzfo0qxyIHBq5nSKo/Lxm6WGh2u4F1ocq62VJY/FPoMKpNLajbUQ1MPPBRHg8tHQDoGhYQW1Zgr2P8UPohkZSxwSjd8lephnDhFmvAzMZRenSenQwo9FfQhbXq+F3SWoL/nMU1y/pNfFd40Mqvwk9cKO9GEvA1eEicExkUgt0fb6lyyjaFstDX0ExSYtj3wZFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(71200400001)(52536014)(38100700002)(4326008)(91956017)(66556008)(76116006)(66446008)(66476007)(38070700005)(66946007)(508600001)(8676002)(122000001)(316002)(86362001)(64756008)(83380400001)(186003)(15650500001)(8936002)(55016003)(5660300002)(33656002)(9686003)(6506007)(2906002)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bnUr56LBlKlJhBd93fmIw/Zdy0wEnai8U9nVN3NdI9jvmMOzMy0l1fb9tc?=
 =?iso-8859-1?Q?kBp5sDGY9DJV4kALMpFvUiMrTX6USFXCCx4iSqHiGk4CfasKWEmYd6f2c+?=
 =?iso-8859-1?Q?z707N2hV5NA7iS+1VYUQgHd83gl71MZxUtxRO/IxCo18uP2hwylsrVjVD6?=
 =?iso-8859-1?Q?HrWXsoYiz4hp8XN0KtJcB2hhr9DgcmrC2D1RTbLH1RAdLwGNE0ppezE4xL?=
 =?iso-8859-1?Q?MSgkTRcUmieWZ1wu87uhwK2ah8krikcphGIkxAwnl3xMXl1BOvAssn1Ewk?=
 =?iso-8859-1?Q?LVODYwpuzJg+4yM4xSkM+9NKOeq79VGXLumuk01A/Y093IYyDpe1F4DRD+?=
 =?iso-8859-1?Q?p7DncgAYZB20NDcaLoe7SUZ4e3lC2Eq0/uSKronHlZTY73rGFCO3D6R/FH?=
 =?iso-8859-1?Q?X8BOgxKK6h9gykkSy6UXoDELlR4QM7nL863z14oWQsdJHEc9ht7ZBssqTD?=
 =?iso-8859-1?Q?Vh6r/YGu+2iUAdIUfOxwb4B2uIa1AlKzFX7/vIuRQhqVXk1LXtOLrMkuNC?=
 =?iso-8859-1?Q?0WbGMjc4xGVeeQ2LT2YLLeWZcnAeb3Q4Ct+bC4tWEv03Xb3s+F9Kt41EpC?=
 =?iso-8859-1?Q?Jgg9wQTbaEEJXwOlUQgfxslAb3LIGE6LhEf7ivmsGvkIdoxrY8X8kL+KzY?=
 =?iso-8859-1?Q?x8bTEaf0ZuFBVwMYbPkYdF3SEbltkRVlVwFp1PALj0+iXzpsuxVrL3GwvD?=
 =?iso-8859-1?Q?PrDCWLhH3tz2KdGjxkV+NDh52ZZmcSU2lrzm17nBK2xOvS8xeAeOreaKpt?=
 =?iso-8859-1?Q?E0sEvpYEtfIS9HrKEcZFihwADWCTGuLA57VYWM4rprXxebTl3r7PknPKdp?=
 =?iso-8859-1?Q?DFWkiXCvzBUAvxi+UQB+zX/FeLphZrCDzVFyz33APBTcSpIv7LbzzjrzvG?=
 =?iso-8859-1?Q?ZPujT8OmrW2M7mmrtlCk0F2biLPnxdmdpwDfCqvKw7gYDfCPTVin89PHaX?=
 =?iso-8859-1?Q?eu755B7RuNVfw90YgjxMIi511Z++8HVzMXcO8YeO9wMbkwdFqRKYI0Qv84?=
 =?iso-8859-1?Q?uGkTvmcmv/nHnsUoYE6f+7EwRsQ8hIrfF0rMGKu6uujihmcI8E1ZS6raIm?=
 =?iso-8859-1?Q?xs59NwAv6xLXfeXp8kV4AW66q64uPLkXoeOsPscY3GfBqFbV+ZBP0zPzO+?=
 =?iso-8859-1?Q?YwX6S9yf04N267LPZfPS3xdKnSi86nwvB177/+DvUNVVIjSdw9X6xFLDfu?=
 =?iso-8859-1?Q?fBWeKWpNSFqee7XK77FzYBppMNBsechm0EJty9NY46X50qj3A8iek3sk7/?=
 =?iso-8859-1?Q?z1zH/cMezO7bnH3G7uD8rsptuI5J5oX8FbBTlloLmVIYKQkwp7nx62mIJ+?=
 =?iso-8859-1?Q?SfRnhrZBmsNoBktvMyJXWojUu7cHFxJhlXubi8U2j2r9de+mNel6GViMDL?=
 =?iso-8859-1?Q?q/96ILgR0FjNua9eenfk2nO8XG8HdxAQkUc6gTvx9ONMeNGefxpvuEOeUE?=
 =?iso-8859-1?Q?WUSjF6dltYqOi7DlfXoeUnWsO+XB9v498ZthHH70B4wykJ8eUIBVIYCnCg?=
 =?iso-8859-1?Q?yDi+4rhd0miinxOW1SmSdmdYNHxkaWLWvXn7lycWfuuamDzRmv6rDwkmSM?=
 =?iso-8859-1?Q?/C5jd5VowfDr7PNtgiivbQFewRAYR/vNafEQOgq1lFPvvgirvCHxMpKA8P?=
 =?iso-8859-1?Q?qnIY0NdndAnGz93wXBU95mIpxM1gqgpQZmxWXA/5O+0QWO/tzGLVgLvYkG?=
 =?iso-8859-1?Q?+vpqfHruVDWwc3SB2/f7BitHDV4bo6qLynlvjvKTg1NQ46jRwkPy8ogiyo?=
 =?iso-8859-1?Q?mWlT9FTCeSzIX6h07loFQRAd5mOcHr8vs4rC2fCNKE+ZRqzIkhAbtmoksF?=
 =?iso-8859-1?Q?Tr6HIsXkm0aA2DJcb15+hwQRv8csT66+FLcA72Df40SvNZyXEHaKRHJvSB?=
 =?iso-8859-1?Q?ke?=
x-ms-exchange-antispam-messagedata-1: CVjcfaChaqFfRg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e46f06-d11a-4fad-a167-08da10ddaddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 17:09:11.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xl+/EwJzkKY/QqtukpytGKOYaoTW/EV7NRHi27JbU9pm+1ij4dZ8kLjYZx00kEQmHtgVp+SY3wpvWbtxsviiVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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
Cc: "Su, Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks Luben, I've committed and pushed out these patches.

Cheers,
Tom

________________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Sunday, March 27, 2022 06:42
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; StDenis, Tom; Su, Jinzhou (Joe)
Subject: [PATCH 5/5] umr: Completion: update new format options

Update completion for "--ppt-read" and "--gpu-metrics".

Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Jinzhou.Su <Jinzhou.Su@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 0e1444357c82a9..bd0b61b2d38831 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -333,7 +333,7 @@ _umr_comp_ring_stream()

 _umr_completion()
 {
-    local ALL_LONG_ARGS=3D(--database-path --option --gpu --instance --for=
ce --pci --gfxoff --vm_partition --bank --sbank --cbank --config --enumerat=
e --list-blocks --list-regs --dump-discovery-table --lookup --write --write=
bit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read =
--vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-fi=
le --header-dump --power --clock-scan --clock-manual --clock-high --clock-l=
ow --clock-auto --ppt_read --gpu_metrics --power --vbios_info --test-log --=
test-harness --server --gui)
+    local ALL_LONG_ARGS=3D(--database-path --option --gpu --instance --for=
ce --pci --gfxoff --vm_partition --bank --sbank --cbank --config --enumerat=
e --list-blocks --list-regs --dump-discovery-table --lookup --write --write=
bit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read =
--vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-fi=
le --header-dump --power --clock-scan --clock-manual --clock-high --clock-l=
ow --clock-auto --ppt-read --gpu-metrics --power --vbios_info --test-log --=
test-harness --server --gui)

     local cur prev

--
2.35.1.607.gf01e51a7cf

