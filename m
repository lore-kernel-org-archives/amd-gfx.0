Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D4C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F558613CC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F558613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D202D6EC53;
	Fri, 23 Apr 2021 21:25:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7E56EC53
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 21:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvyllBWS8vndavSYeFRvmIcEiIciSUzV6mxMW5LXnAkojZpH/XPeQwPcxf6vL6C1enDWWNhBnA6ogI5drP9iayPFKMK/hRpnKmfPHpXLogAzsHF5nhDvvu10oR311fu2kSMSiVjlzssSXSA+J2EJvBiwmuDcd7GXcwaTLz7arwHIqKGhLq0Za2iu43htGriL6WVLPBJcL857Kw9OSwXQE4J2pjU+Rgm5NIIKcjnEtjE2FIcRhhtREVBGBdk+LJrvhh3Jw6+T7oYwxJQirvVVFwIjcYtTWKMw9jwDNk3cg91YDODqexhBtGum82t2VlLNiNduUwNnRUalnIGuMLcP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+kHnzLaXZ+WaVwkqjgn+rxNySaM2IEK6BpPvegzPY=;
 b=RT6v2x9LsdG4A0OJDLlYepmA/ABHuzbd2zmXmg1T5/3YLkPHp5tAsMUjycvee9N+Pya8+SY5gNmwRlsD5dwwHJz9/d3R6rbEJtWFnzCAqMgPAZ6i3vHbpuo3oK2WgySAK736DMjqoAWuEYQgkTaqBX/mckFSY9A3I8+CluSkV9+NQS+zILyEfV4z4HHTVf0KLuRgyouhtVV8op7ThEAplI+c5e9gZuApBrBP8tkR+6XeDaRXfgfqi4SdbGX6F6FtFc+OMs9wPaetcDfi6J7U7iYscotkPnn0g1J285YdFM7rEG5pgS1wEcBNcHGN6W75gcEMuWTBOpoj+47R+KkVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+kHnzLaXZ+WaVwkqjgn+rxNySaM2IEK6BpPvegzPY=;
 b=bL5zjjSo7UPOxeYwCCOWPgC+bmJRWUsJJ4LZNOKOc80wvCCRCJz81KyVuPeK3c8l/DEXH1ESuxMAu2L5/xKQ0go+4C21Oh3rHxAZB4nxJiZkQc8xzQv8WqTfDizDag4uGXhqIbbhukKML3het+7Rib1TL9WALKy3WSuorsglYiA=
Received: from DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) by
 DM5PR1201MB0251.namprd12.prod.outlook.com (2603:10b6:4:55::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Fri, 23 Apr 2021 21:25:32 +0000
Received: from DM5PR12MB2551.namprd12.prod.outlook.com
 ([fe80::b58e:4d5f:5822:cbd3]) by DM5PR12MB2551.namprd12.prod.outlook.com
 ([fe80::b58e:4d5f:5822:cbd3%6]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 21:25:32 +0000
From: "Ma, Hanghong" <Hanghong.Ma@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: add documentation for
 dmcub_trace_event_en
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: add documentation for
 dmcub_trace_event_en
Thread-Index: AQHXOII50nTRnlBTh0K+1rYA62H/o6rCnEjw
Date: Fri, 23 Apr 2021 21:25:32 +0000
Message-ID: <DM5PR12MB255152620600A30438129470F1459@DM5PR12MB2551.namprd12.prod.outlook.com>
References: <20210423204931.428241-1-alexander.deucher@amd.com>
 <20210423204931.428241-2-alexander.deucher@amd.com>
In-Reply-To: <20210423204931.428241-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-23T21:24:51Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b4a184ea-5b0c-4ba0-a137-9ec973c96e9b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4de89b4-51d9-4650-a6e1-08d9069e537a
x-ms-traffictypediagnostic: DM5PR1201MB0251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0251DF5CEA5A84DAD9D02197F1459@DM5PR1201MB0251.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aH9dIGNgK8P5yYaYSJN1hYM1d4D25aSg2HX0RKkDkJWEbi3v2Rb2S4UQDdutaym2Dln7D1UlpHWjP1PyDpuc16z/CTJU0GBQMo9tyISuwa5FSRqDUjW5s092vT6ZTlfwKNMGG6JV79gfXeeMEKqYKsPMuwKU7YCqiXRA9pfryxhr4AZ1Xv26SCMMSY51glQMHr3VjK4JVJkCDBWo5lkGBeauK5ypf13d1CUOwc8jKOgJrOxfoa60pU968PUcICQBqPl7jiy/cs8iSIW0/Fbb3Ni/D03jy1SJFS9PuKjp9xt3HTmujISwVgfFXqLRnJsEXJkA+kbkXb6V1zhttY8TtjpfTevJYvzNGWmharVUri+dQa1BKSMbazceNLwkDjVE9o8C4fw+6H9tNLmIMaAQbuSI7DD01k0DwXEUjYsS1IPjRFo1Nhf510e/7K33nfJmWM+XnBKkuLFNjoEDv0AgVDu4ckTwAf01IOwhTs3BhgJN6q195DR6yDFDntaKAzcoTsGpn0NQAQhoPIlIqd/EVTjDZixehBTsOe4huNZHoVlitLPyO5LHnxXGzEN6F1xCNJ1xfeEwKxT5w5Qw8w2X4e4dvoBeANccj2kI7mNnHf34lEI0GMrZqVFuXj9WeOYffCMEj/bJwmpiTjZXjP5DEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2551.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(478600001)(6506007)(86362001)(4326008)(55016002)(45080400002)(9686003)(53546011)(8676002)(7696005)(5660300002)(71200400001)(38100700002)(122000001)(76116006)(186003)(66476007)(66946007)(64756008)(66556008)(316002)(110136005)(66446008)(33656002)(52536014)(2906002)(26005)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R/hovqTdTbIH/6QB9kvb4o7wWJLveWUxWw/bB9esdhie2YHBetElMKXx8vK5?=
 =?us-ascii?Q?nz3AaoYxYNlE8oig0LmymXTpImfx0JRhhn20QIzqNVgIarE+mMpdkKOgyrI3?=
 =?us-ascii?Q?RGes5bI6NPVuSbLFh1z73+V+PEATTz5RVKwM9hlPRtjxoULusIXgtft0oADh?=
 =?us-ascii?Q?mX6W5u6kmNv0ww0r6yPmq40egVbBd/3tlHhCgzYBT18tJM3LOoic8OHMCKCX?=
 =?us-ascii?Q?NVePC7bCKdp7FauUV6bYvuB2kei+T8/dp5ElRKd/1GnYGGTCRoE8v9xLZJga?=
 =?us-ascii?Q?kdOdGM5FLvMyjWj52SJRdoaE7x9QyatR1hJsrfrkE9IWiIOfUCj9wQ0mzRVr?=
 =?us-ascii?Q?kDEMmbQ/aEMwj3PUasYZTqsVy/1p3eXaE8X5c4pV98oIu9Qs/qowCFnsUWsw?=
 =?us-ascii?Q?3fL6OsfbqjE4RfxN4R4cv78mBv/rCJG3MNXuI67Xge6fzjfCzZNy5vRrLtix?=
 =?us-ascii?Q?SPBxeHpjDU4yE0LKffGsKsyOpzF0Caxy6bc6HhcTvgbwlvbFfcW3UlFZBSvS?=
 =?us-ascii?Q?zNfSPoyJzeIk5WeGqwzHso7J1wyoMkIn1RCxukrSg8qR0Fqnu07qdic7Y1AB?=
 =?us-ascii?Q?n50bIlu4U+CSrR7v1TM4ezCbd44G1lhZjZDat4eOHSiTVFQHdCKrD1td3ncB?=
 =?us-ascii?Q?mvLufQc05aMsCViAS25o9+qpijfOW4GsOSch92Nh/TSxuMASOsU0cvYzQRir?=
 =?us-ascii?Q?/9ZaHby3mXrLZU1KJovayxajPu6yuMZrbKEb2LcGK/q9d1N7SWp0LbNRk9VO?=
 =?us-ascii?Q?pREBuQfJykTkvWfEC6UZildEpC5gEq7dyIqy0KjtmUJALzE0RvysEK0NsJwN?=
 =?us-ascii?Q?uBCTv7+jDg9MMX18JpTYi7M1rHpmx5Xrzzch1QuCKrTb79Ve72rlVNns8psN?=
 =?us-ascii?Q?3TF0luNOpDFF3dmj/DTLbDRVB1HZfAX3oHrrr0OQUQzpRTvamzt8FLyb9r1G?=
 =?us-ascii?Q?OAgXrFVWgf6Khll0audCfwTukZ3REyGRHh4xslW8t+2d93A1Z43JQadvCj1F?=
 =?us-ascii?Q?c7U6Bo5bbqKhh2jKiLj3ml7rFgAUGVT8BWjGnlpu4upVo1rMnyJNzVVDSUyi?=
 =?us-ascii?Q?L8OY1Ex0+sXU74tLE2wfDqyiyK4yUP8lnpOv3Le9RvW/gCliNwD7AgY7wRgf?=
 =?us-ascii?Q?4NDI2kNwD7o15wXF/aMEazvxaQrnZWm1g/m66i6UlxmtZ+7IDXGW4H+2s7ou?=
 =?us-ascii?Q?9eSDOxN5EamS2Q/DUpgovNw06fsBmF5pokx3DXHwbBL2fh6v1LRoCJSIPoOF?=
 =?us-ascii?Q?funQqk5apZQReiZeDxiqEeZaNXWuxBXWFINZ8v8VKs7tlWJYa7S6/AOF2OgR?=
 =?us-ascii?Q?xqr7LoJnwx0GPan5vvdjnlQs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2551.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4de89b4-51d9-4650-a6e1-08d9069e537a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 21:25:32.3073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/41gw7iFL7p8eXluNu/kdV4nYOvaIfu26kFt1fZScDTDuGvsaJrN05mHm1UalWTbV12d59+YH8JBt2PQpdx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0251
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
Thanks for adding this.

Reviewed-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>

Thanks,
-Leo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, April 23, 2021 4:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: add documentation for dmcub_trace_event_en

Was missing when this structure was updated.

Fixes: 4057828a1283 ("drm/amd/display: Add debugfs to control DMUB trace buffer events")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d6a44b4fc472..fc13e8b6ea5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -168,6 +168,7 @@ struct dal_allocation {
  * @compressor: Frame buffer compression buffer. See &struct dm_compressor_info
  * @force_timing_sync: set via debugfs. When set, indicates that all connected
  *		       displays will be forced to synchronize.
+ * @dmcub_trace_event_en: enable dmcub trace events
  */
 struct amdgpu_display_manager {
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Changhong.ma%40amd.com%7C3683db935c514d384c2508d906995b09%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637548078001885496%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=wolXr7Q7EXy6WxvDoyK5yFmPVHYZUcA27IqkS0Sli2k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
