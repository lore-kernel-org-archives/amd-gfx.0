Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7DC2D0EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 15:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAF920776
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 15:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HF8IaH2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAF920776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06316EC44;
	Fri, 17 Apr 2020 15:40:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085E56EC44
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 15:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz5EYdpw61IUtGGnr+7xopMRQwGBQjV2fL9EbRC9XChIcPnaUnREIOhYds5OVbZehXhSwU4ZfP84LsbnlZd2A4qf350cFw9fcerhZbUOwEksZGwv4cmNAYcSLB72OV7rVxYWbp94PmeyVEovFfl/dp7Yz74ydrH7vpBS2d01fMl89hbQt5MpNIFgwlgHa+IHK7rkZHi0aA6bT5Da+pJ4z6WhPoHElli1CwPddBBb6ykoKq/5x8iyR6O5GaXN+6hfy8Jjcb8C1SvApvetzuz9mw0QbGWOUXGetKiy2HtQZhTZN1wpGPAP9EsvctWE7TE9ivrTcAopdc3HzvHXA8UA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTkm30oIYqA8vJnjNXc0/SnLj5u9rD8RadoIkSChXxs=;
 b=CRMwKqP+yVZwHkI18n80oKd8gDmE/otUKCIIrk58t6vj9UmOuhYXnLht2U002lRiK60lcrIUfGNbCh8fSvHwVpV8PWjN07vgGnY+ewgthMKC+ytfl2R0v9KKqqOgyjueictnz77a9MESp4r9rM9N9/u9OvPI7Fkv/1RzegQMLj8Nvak0bOGPxph+d3GUeJn6Y4FivZed9OsehqJgFD9o2nzw5n5ZX95mLrBNFj/Eh4aphSFIPjl3Ar6g7WlWNtYzSWOMNxpiAp+LMwo/bvQZ7fo61Jt8ZYxI4V1LBOlfwYm/8gvUoig7sn++FnTl1WfeRZ8mD8dPjOVtO+kXSTLfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTkm30oIYqA8vJnjNXc0/SnLj5u9rD8RadoIkSChXxs=;
 b=HF8IaH2SdGTNokErex+rEvo77MgHKoehpLAK1X9eF0ThzYyKvDXaPWMOhgigkLPhKAYlntuiyVp4nRminpLVzxy1xIH+kIGRJ/myimuFNCVYRYVlITRYTYvmJ8mzakC8nZg7biRUuwsku+CNmV7cJSLgnAxcxEI8ZAweAumzY6A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 15:40:33 +0000
Received: from SA0PR12MB4382.namprd12.prod.outlook.com
 ([fe80::6550:371f:543f:5283]) by SA0PR12MB4382.namprd12.prod.outlook.com
 ([fe80::6550:371f:543f:5283%9]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 15:40:33 +0000
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
 <9442cdf7-4aef-7831-2609-4610b09e15b8@daenzer.net>
 <1bd26e82-3afe-192f-36c0-01d836329196@amd.com>
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
Message-ID: <5732a88b-50b1-8b48-b354-906a8c2c2284@amd.com>
Date: Fri, 17 Apr 2020 11:40:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1bd26e82-3afe-192f-36c0-01d836329196@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN7PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:408:34::47) To SA0PR12MB4382.namprd12.prod.outlook.com
 (2603:10b6:806:9a::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:9240:c66::5] (2607:fea8:9240:c66::5) by
 BN7PR06CA0070.namprd06.prod.outlook.com (2603:10b6:408:34::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 15:40:32 +0000
X-Originating-IP: [2607:fea8:9240:c66::5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36246ae5-bc20-4fba-5dbd-08d7e2e5aa50
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:|SA0PR12MB4574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45746742B7FC923D326538518CD90@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(5660300002)(54906003)(6486002)(2906002)(36756003)(316002)(52116002)(110136005)(31696002)(31686004)(53546011)(2616005)(66556008)(66946007)(66476007)(4326008)(478600001)(8676002)(81156014)(16526019)(8936002)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4NZvitaAj0Vt5rc/L7AVTrv44lfkCjTWlK6SK+1sqYxOHiKo2cCCHRe1rMAUowSLTAR8OHMcQYmL8swzAh9egDJhOXnw30enbTOi4fFdmcm08Cde0iQqvgxGDlS22xmTNJHhUdT5CTI8Q/x8tlj9mLpNGk4OOKhC63k+0ImLmbxylNMsRPPs/gC5TWpPj8K+57HcoLqk63SjaOM9Wb/eHlQrQoacrJNKXAdieNgTaOaavzWh//TpkOt4g/ZGy2yxRHOCpyWfaxfl0IwyHSta0W23zEXscYmlxl83LS37U5oGUqKjsYDybyvAnQRGBQTL+xqYARkxIFXcAf0/cVuc91aiKAeifRALdW5WstehRPM/PlV8N8eaHZ0RbkbPxacZcbBIrqVpsNEvSs5tSWGkI/YpLxS7IoGh88hhUThIsgYIW1xAm+xVZWh6NRNss2W
X-MS-Exchange-AntiSpam-MessageData: dLKXoun2hFKyGNKByx3Y/bP8vGExiyvRIstsgTEVW1oHoTwebfJP9Ag9zPdrIw+J6zwNEg9vYgfCOChqY/XLWRnfYVVCeeJshpeT/bESKY2CwKUjHpi0ZleKvGBHuO3yTd2K0jqQnj16hx61ImW3v56ef4BDrvTq3qoPlfGnnQs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36246ae5-bc20-4fba-5dbd-08d7e2e5aa50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 15:40:33.0619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGb4RhZQLsxsAWUcvanwpm4aScSvjp8xhbM0YxKQblmUJlTb5MnEcVOXGjQMUt+iPRu4U4uT070OMCtz8hCv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, "Wood,
 Wyatt" <Wyatt.Wood@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNC0xNyA4OjA5IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTcu
MDQuMjAgdW0gMTI6NDMgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4gT24gMjAyMC0wNC0xNyAx
MToyMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQWdyZWVkLCBqdXN0IHdhbnRl
ZCB0byByZXBseSBhcyB3ZWxsIHNpbmNlIEkgdGhpbmsgc29tZXRoaW5nIGlzIG5vdAo+Pj4gY29y
cmVjdGx5IHVuZGVyc3Rvb2QgaGVyZS4KPj4+Cj4+PiBUaGUgY3B1X3RvX2JlMTYoKSBhbmQgYmUx
Nl90b19jcHUoKSBmdW5jdGlvbnMgd29yayBkaWZmZXJlbnQgZGVwZW5kaW5nCj4+PiBvbiB3aGlj
aCBhcmNoaXRlY3R1cmUvZW5kaWFuZXNzIHlvdXIgYXJlLgo+Pj4KPj4+IFNvIHRoZXkgc2hvdWxk
IGJlIGEgTk8tT1Agb24geDg2IGlmIGV2ZXJ5dGhpbmcgaXMgZG9uZSByaWdodC4KPj4gVGhlICpi
KmUgbWFjcm9zIGFyZW4ndCBOT1BzIG9uIGxpdHRsZSBlbmRpYW4gYXJjaGl0ZWN0dXJlcyBsaWtl
IHg4NiwKPj4gdGhleSBhcmUgb24gYmlnIGVuZGlhbiBhcmNoaXRlY3R1cmVzLiBWaWNlIHZlcnNh
IGZvciB0aGUgKmwqZSBtYWNyb3MuCj4gCj4gWWVhaCwgdGhhdCdzIHdoYXQgSSBtZWFudCB3aXRo
ICJpZiBldmVyeXRoaW5nIGlzIGRvbmUgcmlnaHQiIDopCj4gCj4gSSB1c3VhbGx5IGNhbid0IHJl
bWVtYmVyIHdoYXQgZG9lcyB3aGF0IHdpdGggdGhvc2UgZnVuY3Rpb25zLgo+IAo+IENocmlzdGlh
bi4KCkkgdGhpbmsga2V5IGhlcmUgaXMgdGhhdCBkbWN1YiBGVyBpcyBsaXR0bGUgZW5kaWFuLCB3
aGVyZWFzIHRoZSBvbGQgZG1jdQpGVyB3YXMgYmlnIGVuZGlhbi4gSGVuY2Ugd2UgaGFkIHRoZSBj
cHVfdG9fYmUgY29udmVyc2lvbiBoZXJlIGZvciB0aGUKb2xkIGRtY3UuCgpOb3cgaXQgbG9va3Mg
bGlrZSB3ZSB3YW50IHRvIHJldXNlIHRoZSBzYW1lIGZ1bmN0aW9uIGZvciBkbWN1YiBjYWxscyBh
bmQKaGVuY2UgbmVlZCB0byBlbnN1cmUgd2UncmUgbm90IGNvbnZlcnRpbmcgdmFsdWVzIHRvIGJp
Zy1lbmRpYW4uCgpUaGUgYmlnX2VuZGlhbiBwYXJhbWV0ZXIgaXMgc3BlY2lmeWluZyB0aGUgZW5k
aWFubmVzcyBvZiB0aGUgRlcuCgpUaGUgcmlnaHQgYXBwcm9hY2ggd291bGQgYmUgdG8gZG8gY3B1
X3RvX2JlIGZvciBkbWN1IGFuZCBjcHVfdG9fbGUgZm9yCmRtY3ViLgoKSGFycnkKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
