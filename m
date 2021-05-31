Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CBAC47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 14:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A6A613C1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 14:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A6A613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9B389CA8;
	Mon, 31 May 2021 14:14:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5354D89CA8
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 14:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2cbQSjvqHi7UtxG9aF/FYdo/cJlq7cVVU4oWlR/7fYLcsEE5Nn46j8Z92YRuBmKzCm87zyjAVj9XW5vsV/Lolt2N011lGSZSfoaGJv4Yu3R1B3HDv8ckJ75X+Z/bHvW3XNzN5rr+lI4gQQ+uaa5Hz6qyRiiMniLf1g0cFeIGUv1lhrujngWAdMTfWFONkham9wj016JAh9n6nSMdHq5mQh914AlvcYy/WOFbZmMhBb7oeiNeNjU7qAK2L5MVl/UohBC4RmIQW/jTIbIqvR8g/KlUTxwFX1tnD1NOyFnBCuzKJ98ozySLd4zYRNtvKs3G5G3AZLgyzxmISW/0CVtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upr8sYjHCYGioEFu0SRDZH8Ss5sIgEIVt8pUX2XgTzY=;
 b=JA8zC/erYveoWeHLdV252dlqjbpss4kdFmA8j7QlAbbxEuhoo8vqj6ytlLTayd7X7IFJhIjrgh8iHu8wF5J534vdma7zgpJEjdYcm7glCB5cHPzelU+Ni6Sqs8rIh7uALz6BtnzfXpnfZBzPjJORve4b7NNgpzFPxZl0I5WxtShNbtd68gE/nmafqp55bTsb1GzzRb27c+m/TdQL/BimNU+CIghKGxkOTpBIeOlIjXIRA6eKat3f2w2kwoi+Ksp8WEoEh14qFm5iyZIA0KMx3bXF8uS5t1dkX1/4hNKpSSzNYCGzMa9pusUCqQSLJ1JRZiAgneExYY0Ea06xy2F1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upr8sYjHCYGioEFu0SRDZH8Ss5sIgEIVt8pUX2XgTzY=;
 b=D7GNGo2Ahya/NXGLlQkpZTP7N8+irQ5Y/gTOc/AG33o5m3nxPQIlOqkfegjIoVts8P0oZ7HM2aWTNETcKclymh6fgQcSV0Baqss4TB+bKktJrhTm6oQP1XcVyaD+rjGYAz3Nyht13tUOG7ytGXTILUX8Bka4sJg6ucdQkn7WeKg=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 14:14:53 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56%2]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 14:14:53 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "mario.kleiner.de@gmail.com" <mario.kleiner.de@gmail.com>
Subject: display regression on Carrizo
Thread-Topic: display regression on Carrizo
Thread-Index: AQHXVicrrc1NgRIk1U2QjRt8FzPtAQ==
Date: Mon, 31 May 2021 14:14:53 +0000
Message-ID: <DM6PR12MB3547CA74B0AA230909080A0AF73F9@DM6PR12MB3547.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-31T14:14:53.337Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2:d3fb:b908:583b:772c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed173e45-4344-4fcb-3257-08d9243e7608
x-ms-traffictypediagnostic: DM6PR12MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB45151D8674AB37EFE436B412F73F9@DM6PR12MB4515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvCsn124VSbHKmSYAKcovagxCUD60eqEdRVleYCIlVifBJKdNYEBbbFk4EVGO8frv+JJVKyFUUKL1jgGj1q37uv27FciMTmEQrcZLmmEXDiZELcl46dBTpKZyXGUtyaeM8hSXMXqBbnPGZqyH8lr5TySRtIJEUo2ntuqAU0ICHiwQr7xIKaZqnnTF7rScMHczqFImC+2ldA6Q5NGwCbJSOTmucsbvohUqzfOY+cU8aAbWDfQ1fnvlkAdvKZMNGlRPKvCmrdHIhNV1XSqoVtavsvbG5QPSE9C/mSKjYNPxo3MPKUNPxOZo+Gunqh6o4EA5A4Ulb9ANCTLh9zhJCdvoCkr8xQJqkARVoZx/Z3cITuV3oBVWWZFXg7XoFn5JB186SLHPl1xogfOp3RI0o3nGCBHiM6fVDlP5xPGSjCnNCcMOYs7Us7YYIO8uTvvzs5RdbsBkSCqXNPPdjXVy6Cf+SDkgJuOCsnOYP75efB/cRL5HdxzraQxPMRKhyoJsTWl+olAb5V/QeQs6ESM+n7TWwYKv87nI2AX0547KmeidYVCKyqx0LkPdUSgi4EQ6F5JaaFywpL22YG1pfc9G08TVxjghgz/KDHpWRc/JG/fhZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(71200400001)(9686003)(38100700002)(122000001)(3480700007)(6506007)(8936002)(316002)(4326008)(186003)(83380400001)(54906003)(52536014)(2906002)(66946007)(86362001)(5660300002)(6916009)(76116006)(8676002)(66446008)(64756008)(478600001)(66476007)(33656002)(66556008)(55016002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?S1Qb14NNH9ztKk3fd2sOGVUAzozhNMkUcO6T4LS0Aazl4DgHpnHZb/ZtAP?=
 =?iso-8859-1?Q?keNO3D394/cZb1cTwnA/INt0hsuBRBZoAZLCtdq5GWl24GLNdHi4F5LzsZ?=
 =?iso-8859-1?Q?cYyBrx62js3q2K867yBnWpj+f7n7DbRV4aiDM6niepihl/d0KC+TZWHx4k?=
 =?iso-8859-1?Q?pgTwnYbMoiHGRrzp+BZV48ZtFc9GZr5aTwCZnTpLfdHOcmQN8fjLiyAPCe?=
 =?iso-8859-1?Q?fCrEQUzTclFJS/AY4alQoPAdIvdcU3mkDtxnYvRykIBidaIKM1LqEpsMCU?=
 =?iso-8859-1?Q?jN9IpFpWorKBfFRQCjieNwV4GZjqhgVM/7+sHV+7sW/Ga+kAGAausznQ1Q?=
 =?iso-8859-1?Q?TE0EPjVhYQL+qLMe0bIcotmriAP1vIbCHhXPaAU/2ASlr1+XgUQbpPwe31?=
 =?iso-8859-1?Q?fbYh7wAmtGqt5AJxjWizCPDPN6XpV4PH5rbgS6vyO83ZCqmBeT4jk3xyK5?=
 =?iso-8859-1?Q?1AUAWJiI6lwJY7NE5Qv4tvD+BTnUX7rBMfOgdyWrALnz/OANJpFOHjxHHb?=
 =?iso-8859-1?Q?0ziO0WQ8q0kyH+xJ/M8a2gq/u6FUXIKrhoOSV6s1k1szLhPPeYiaOF5Kjf?=
 =?iso-8859-1?Q?QXJD521+f3ib+xN2pQ3BgxlL4LjI5N94//k4rdFUzFqWFNvnwnUj+X8axM?=
 =?iso-8859-1?Q?zgwPooePIPvj5agPplh4e7YDWKWEo4AwG1k+pN2bOOPE/Y3kf5PioT/ymU?=
 =?iso-8859-1?Q?PyWd1hDCw6KYQZZw+AivXI4Bk/lXMrYg2wFNYS2YxASLSKsY10fX8bWqYI?=
 =?iso-8859-1?Q?N6Lm8qRm7nrTeb4m42+FxOySwur4NZgBDB3x5luzf/eyUhgpdBJhVZD+Y2?=
 =?iso-8859-1?Q?Ejiety9eMPgJHkZ34+ngwTvaD+sBEtqUvB7C/5TnpEgmcVMviLJs8Q0man?=
 =?iso-8859-1?Q?rdV9dUGOWlDtxOe0mmFAUd06zhrKnCgEheIPvzJsVwlm0Xegzqbhc12llz?=
 =?iso-8859-1?Q?Qh4mJHDiSg9GTfckJBnyV3RmI06YMVPaJYxHR63jwiG2FdwIaKjuPQArqu?=
 =?iso-8859-1?Q?qYyZd32tIBg8OZSmiGVxtMCGB3P0CFZ+EmyUDxH1puB5dWlEoa6nev+qpy?=
 =?iso-8859-1?Q?sZHCs6OxgHH6vC5E/kqCqXCRQNJNngDgz9X/0sNZFfzmaaqnu3OYa9QP2b?=
 =?iso-8859-1?Q?5VXbUWQMpb6YPPjJir/tu14P1nwlqBw7TsCFjdhmQYAsYRvu2tDeYdGeqp?=
 =?iso-8859-1?Q?YAyuiZuqXh7LpCBrG/NyRYgDiCO5dJdxW35fJ2BnMz4MITn4URCAFO9Hgc?=
 =?iso-8859-1?Q?oqh5ROd5uP9e1kAPpS9+/xafYOzKQcb251TfX/ILLEk8IiIJLXR9SXXui/?=
 =?iso-8859-1?Q?rVTWDD+HFATlUXeK1ZJsSbcoNuQyDEqsw6YWSLxxeuUCGZvyLhlbLCjiO0?=
 =?iso-8859-1?Q?wXX62waBY8WOSvD1Ij8g+pMz6hGqt6fkByGL3/UU7C5yr1x88unrA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed173e45-4344-4fcb-3257-08d9243e7608
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 14:14:53.5317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ceoNQteQEsEbhQgpBF/34r+xdXUBBhsGbzdDbDaMcEBxMCaJyl2p0ye+O6M6S4rpXJvwdDDuG96PW7OyaObzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Mario,

The following commit causes a display regression on my Carrizo when booting linux into a console (e.g. no WM).  When the driver inits the display goes green and is unusable.  The commit prior to this one on amd-staging-drm-next results in a clean init.

commit b1114ddd63be03825182d6162ff25fa3492cd6f5
Author: Mario Kleiner <mario.kleiner.de@gmail.com>
Date:   Fri Mar 19 22:03:15 2021 +0100

    drm/amd/display: Increase linebuffer pixel depth to 36bpp.

    Testing with the photometer shows that at least Raven Ridge DCN-1.0
    does not achieve more than 10 bpc effective output precision with a
    16 bpc unorm surface of type SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616,
    unless linebuffer depth is increased from LB_PIXEL_DEPTH_30BPP to
    LB_PIXEL_DEPTH_36BPP. Otherwise precision gets truncated somewhere
    to 10 bpc effective depth.

    Strangely this increase was not needed on Polaris11 DCE-11.2 during
    testing to get 12 bpc effective precision. It also is not needed for
    fp16 framebuffers.

    Tested on DCN-1.0 and DCE-11.2.

    Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c         | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c           | 3 ++-
 8 files changed, 19 insertions(+), 10 deletions(-)

Tom
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
