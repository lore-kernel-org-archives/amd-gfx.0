Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B45D59F7D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 22:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFD310E798;
	Wed,  6 Nov 2024 22:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="alyQu7rp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CFF10E79A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 22:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqdfLBiW9TkH2kVDCyMBgo1iyyD1b8KYYONmvqcvutcMGed1RoBzsHifQN4NA/TF2JxZVwANIdufQrniN5MFyd35eAn4v5va9jlttnu6i1U59LpcBWy14lxx/vqdNJ8mafkzqXhPObu1RBHId+QX7TXsu77bQCeOgAMbZ/ujZcJBCJH66tdoF1nOe2b6QSnR3G1Rv3MbrYnC2r1dUkuJhvPtaROKYteZf1OE1uAIF/cIXSqhSdW8buYt2uThgoasUBvNBdLSAEIWCy/s2svnTAx7r8VHHqiC1YnHSf99EnL4zKKF+weLPtg1FJgmwFhu8+xsIUlY7TJ5bXhZGX+6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZErMLiqGox9lCQL52aBpKBIBsln2RRNC6tscskfTr0=;
 b=HIIhcQA6JfeUmiLX7IsKop3sKrqtAPrKcHi8C2cd8ebh6c3bzEOQ3WW0egchcojI2UXgY4J1HwavhuDkOWwjBzaeWPR4FFRI6eODDo70UeNO8xE2BFe5qnW06SdaFfL+rrBJzIQGg83KsJHr/bkUBiZ+2By2d3fVtwZNdhgGon/KC5mEKfjBMoMpejNl0J1iTOubno7cUN3MhxwkMS0qkgITxBHYuxVwblt6Lwcm0IFvFjx8H99yajkJXVH3vu6YmVv0e5zSurOoBl53x0Cvgz5wO/gGlPPs5jpF5dYWSihY3CBQV83s+yaRHBML1exYXGao+EVGrMk+3FgwMbvNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZErMLiqGox9lCQL52aBpKBIBsln2RRNC6tscskfTr0=;
 b=alyQu7rp572HeV871ZLY7ScYnTBliH6LTmKco+fAhYXbwjhq5K+SucBYvbf516ITVP5vKcepU++JQoYb+HbovhrAdvuRGfwbfFFBWtOprwXAe+KkeCS6+wm4L8wipBioTo6CXjDzzVxUlriBQQedp0rk1ffZjeGaianyrQZ1fSQ=
Received: from DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) by
 DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 22:35:43 +0000
Received: from DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d]) by DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d%3]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 22:35:43 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Inform if PCIe based P2P links are not
 available
Thread-Topic: [PATCH v2] drm/amdgpu: Inform if PCIe based P2P links are not
 available
Thread-Index: AQHbL+n7/1yFVNyrt0WBA3cEeWcFELKqy+YAgAACMUA=
Date: Wed, 6 Nov 2024 22:35:42 +0000
Message-ID: <DS7PR12MB8321A392709793B6F881A715E3532@DS7PR12MB8321.namprd12.prod.outlook.com>
References: <20241106011942.319058-1-Ramesh.Errabolu@amd.com>
 <ca008978-ce04-43df-855c-aea2aab320c8@amd.com>
In-Reply-To: <ca008978-ce04-43df-855c-aea2aab320c8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=79f44ca3-d4b6-4258-955f-db8e19aa7bc2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-06T21:58:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8321:EE_|DM6PR12MB4218:EE_
x-ms-office365-filtering-correlation-id: 36871d9c-8f71-4b59-a222-08dcfeb3593e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z3dVdTJlS2R5bnhmRGh1S2VhbW5FcDFKc0R1T1dhcnNzNmNKRmM0ZmNEOWgx?=
 =?utf-8?B?YmRQNjloSU8wVEVOWGVYU2p6dDhlT1FDMWwrNUptSGJkT1l5UFo3NEt4OTFz?=
 =?utf-8?B?aDFVNjR6OGp6aVN4TnVaa1RjYmxmUmxKakhPczJZU0pBdmd3OW1adFdrK3pP?=
 =?utf-8?B?MEU1MW5TcmlncUhMREFDTk1DM2lrekUrYzlSUENON21saXkxNlowK1hkWEhS?=
 =?utf-8?B?U0twa3Q3NldBTWl3MllNb1lMUnA3aExxRlJKOGV2aXhlN1laQnc2MWRKN1pY?=
 =?utf-8?B?ZURpa2UvbVFSM1JQdkhtQ3RqRWJrRERlT2R4UHVVeldVb0laM2NKTUVIY0l2?=
 =?utf-8?B?ZlFBemdGMmY5dDJ0VnNXcDQ4RGhwc3FCNTgwYjRpa0wxM29Kb3hvRHczZzVh?=
 =?utf-8?B?Qi9FTGRYM3ZKRGpwK0xVNVN6NHVtQzNpNjNFd3pNbzdST0JPajByNFdudjNz?=
 =?utf-8?B?bTZuTi94K0JPemlhSFNjL3pwRVlvelVJS0o2TGQrTjAxalRjY1R5Q2dYTGdO?=
 =?utf-8?B?bWhkL01LL1BrZWZqOEFOT0JIcktDZDNzeW4zRHZOSXZoN2Y3Mzg4Q0lsblJy?=
 =?utf-8?B?V3drZ1BCWWVqZGxmbXN0aUcxeDRETDcrUFM0dFBONXF4Mm9VMTAyY2NJcnNs?=
 =?utf-8?B?SFl5S3RHWkpLK3FhNWMwVFZXR3o0a0VRdW03MnRyZmNtNzhsbGxTa2hYOGJp?=
 =?utf-8?B?TGdLa2hmd2RVQkZHazZnTE1KVWhLSENNOTIzdXVvWUwrVXMyVnc5WHBPVEZL?=
 =?utf-8?B?ajlJSnp3cWtMRlhnRTJkdFg1UERFTEtQSko3NC9nSlJxUzBrV0dpQVVZdkFQ?=
 =?utf-8?B?ZzFwb2wzKzB3eHZHbCtCRDZuWVRlOW9pb2hkcTAzcHhTZEZQSHNJY0h6cy9q?=
 =?utf-8?B?bTA1MlBmeXRvVFlhTnJJOXRDMm9vNzlLOHZ4aXorbDE3a1NDaFNrUlpiWW5i?=
 =?utf-8?B?dzRoRmRad0JLci96WFNTYi9naVRGbCtaYUtKUnJrZnZDR2hvbVNhcGw4MHJh?=
 =?utf-8?B?QVgxbXhpQ3IxdlhtUzNqV3FWVlNmUkI5UTl6bnZCOThTV2JJcERFcmVpaDVB?=
 =?utf-8?B?ak1rdDlUT1I3MUhmcFdZTDBSK0ZwZncrNnlYSTFJcVEwbUhxOWt0N3NWcDcx?=
 =?utf-8?B?bUJ5TmoxamJ1aUd3U3pjaDd6UitrYkZqSlVlbmk3OUFxRHp5V0VpMTMwZEJE?=
 =?utf-8?B?S0pZdUh6Q3I5SDNjTVV2ODFoaW1aMG9mTTMvdTNZUWx4ZUcxeGs5V3ZPZUFM?=
 =?utf-8?B?MnF0WUNhbGZXOXdCNmFGSnJ3SkV3M3FMS1J1ZHpiTit3R0tCZVhMZXRuWURO?=
 =?utf-8?B?d1NqOVE2RmR6QlA4dGoyajg0ZDNORThoSnZzbXl0MEVaK1M1Tk8yampTSnBh?=
 =?utf-8?B?UzZvTEc2RmgxOHI1YmFwZ1RlcE1JL003R200TmtNdWhtRTZQQzhRY0lVS21i?=
 =?utf-8?B?ZW8zTEtsTFY3VERGSzhCL1NLWXFMMnFycGNIMHVlelUrOUFoOTVuT2hCc3NY?=
 =?utf-8?B?THErRUhzREk1WDhHQ01nZEZadTlFWDhKeG1vbXFpN3RGRk1ianROVmFGNndh?=
 =?utf-8?B?YVZZak8xdnQ4eFpQSDRqUkJMZVhMOXZHMGYyU0dPNDRCc1FWNXQzZmNYZFE3?=
 =?utf-8?B?a0RQK255TEM5VUV2THdWVkJNcTAzL0hySFoxNlIrRWNQRyt5N2xtN1RqNjQ0?=
 =?utf-8?B?bjRmdEQ5MG1DT0QwVjJ5SForTkMrZWJ0VFlTWkhGNHA3MFNGRkxDV0pLVFJ2?=
 =?utf-8?B?Q1RwcHkxODNackl1Y3RrNHc1NFprSkNJY3pNMW1GWXhLbit0WktMQ0wyL1lr?=
 =?utf-8?Q?Gzv68rgM7gOYnS5Rn+JyYq6GI+PVvy2tZCzc0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzRQTmliUjN4dFlDaFBwb01LdGRjUlJZSFpzM09YQVNvT0xwVGtuOGdNMzFo?=
 =?utf-8?B?azRyd21XQ1dRcGVCTEFZRVI4dks5azFDTDliVTVTL1VGaVRqdnFNWHVZSVlG?=
 =?utf-8?B?OFA3RWRXN1J1WU5YcWpTVDNBSGVjZWFTdCsxTng1N3ZXSkV1VHVrNzNTYTJN?=
 =?utf-8?B?UDZpajQ3a2phSFRZNEVoaVZ1eEZYRmxvMnVQWVZZSS9NYm1GMzkvaE5BeDhT?=
 =?utf-8?B?Ni9idlRIWVdhTmxSQVcxVlYzNkUvN0hxM1ZtVkprNncrUkNiUzVGYmk2WmJ5?=
 =?utf-8?B?ZXRWYUxEeGZTS000RW9NNUR4N1B4YjM3Mk12ei96dlV2OGRWMUEvMXJObVFU?=
 =?utf-8?B?dmhtQytEV2NjR2ROS21rVnFSOGRwNHdhUlRpT25UTFZxQ2hLVGhsSnVxb2sw?=
 =?utf-8?B?b2RoS0xENzlQOFhZN1R1aGZCWWlZOVFuOUxUdTQ3SWJQaCt6RlhsbVAyeVhl?=
 =?utf-8?B?M0toV0VkZHh5dDBSWTdQemVaRjQycWc0UDBwTFVHVDJ4VkZoZWFZRy8wQlN4?=
 =?utf-8?B?cmF2R2lvTUtxb1l4ZndldHZLbkFvRCtDVHlCTmYvTS9RbGt1eGZYRmVZeGZu?=
 =?utf-8?B?V09YN2RDT1Fuem5uRDRaTnN1MEZIM2FlVy9LSmFtTzBEUnFXek05SkZJSGlj?=
 =?utf-8?B?QnhFWE9NNzBhQnBTc1lTUGV0aE41L1dLNmw3YU5rQlVXdlFRY3lCY3hJS293?=
 =?utf-8?B?NVNxSnhUbFFid24waFdQL0pwbytGY1pCblRjNkJmUWVzM2w2VUVSV1kyUjV2?=
 =?utf-8?B?MElZWEJnQzV3MUp0TjlNclAzL0FKSnVsalhLa3l5WUhvTTNPZXlJYXREVzhy?=
 =?utf-8?B?eWtWTlIvV0g1cFkyV1o4QzNKeGtNdm1USCtUMm5tZkxtWGNJNVRPQTdxZFlu?=
 =?utf-8?B?VmFGemNqcko0VGtwMk1ubG5Xd1RYL2ZEeE41TmxGVkQwQVlxUG9PeU1UVUFQ?=
 =?utf-8?B?TjVVOWllN2dNV1JBRG1JYldHL0FTOUtEK3lnVm9VVTArNHJYUEg2bmdWeGRH?=
 =?utf-8?B?ZDUwSmRaUWlnb084emxWN2dXQWI0MndFWnQ5ZTV6VE1HZnpwaklkQlpNQlpP?=
 =?utf-8?B?NXphS1hIUFUza2lFUmIxelZBejBVSHU1WnFOdHNXWXAxNlB4Q1h4UFFTaWk3?=
 =?utf-8?B?MEpGTDhKWjBNWmEzbVNxYUhOMDlCdTljdFd6dnpyclVLOFUwZHFlZHRJdnFy?=
 =?utf-8?B?QytJUnloWS8xTExUUWRzb2EzZjUwZitQYXBFWjZFemVnaXUwc3BIMXJHNmJN?=
 =?utf-8?B?OHJpL3lrRlIrMFE4UDVhK0NneGpKT1NhbWpVTXdBOGJRR1dJZVNMSkZieEov?=
 =?utf-8?B?bkttOHMwbmlCOFdhWkVLUVNSYmQrczM2eFp1YnpTUVNyNGUyTWNxekhFUkY4?=
 =?utf-8?B?WVFJOGFVMmpFelVBaFNmenJmbTVWY01KY29FZVpuZUJkQmdTOEpKUmZLbEJj?=
 =?utf-8?B?WTlWZXR2bXNlMU5VYS9UTmhRZnlTWXU5Z2JQZVA2cnIxdytjTjdNbVJmNWRW?=
 =?utf-8?B?SVR3VkxOOHBuNGpnRENWOW9kVXJPZXRmQXBpMXV5OWZ1d1ZtbzdpUFZLajdl?=
 =?utf-8?B?ZTRkS0U4L3h4eVVWTHduVmtTUGwzRnJYRWxyZFRxV3liOGtReTJOM2h3cGww?=
 =?utf-8?B?bDc2UGd6R0FXZkt6VHdNTGtuQ0ozQ3BqNThreDlVMUxwUkUzSWlnOWtJdkRR?=
 =?utf-8?B?MXVlSEgreHJ6RlJWNDFGWjZ4WFhsTU5rNVE5VnExN1hsYWNwVTVkT0NyYlNS?=
 =?utf-8?B?Um1BcXNuTjhXenI4SUF1bjZ4SXRqaEVjakR5SmpvWCtudHh5N1pHTHExN1hG?=
 =?utf-8?B?YkJKN1JxY2ZGQmJjWnpNZm1SZFNZRlpDSXhXK0ZQcllYK1JNU1NOSUtpaElS?=
 =?utf-8?B?cVJqc3dCMTRLbmdUdFZ2a1hzaUIzamtLTkJ1SjByN3NrTHpZTnJJYzRFK2Jl?=
 =?utf-8?B?L29pQzVPR21sa2x4c1g3dE0rZ1VhaldXRndLSHhyeVQxd2N6d3ZVL3IyNHBM?=
 =?utf-8?B?UWJHNVdBZjRSaEZJUVZVNUx5VHRNT2lLcjRZbkd4RWpyb0lVYXdCUVpYakdn?=
 =?utf-8?B?WTdISFhENmNSWWxUb2t4RjN3dlYzL3l6NkVqSVRYcnhOSEdkVVprb1lQaHpL?=
 =?utf-8?Q?dj8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36871d9c-8f71-4b59-a222-08dcfeb3593e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 22:35:42.9225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0E2kUE3NG+0Xw0SQb/VE1BKnoUEVQlt3eX04SbHkvLBO+U3bI8btKnKhk8TjTSV2VqhgblJLFdUmL/aZRtSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KR29vZCBzdWdnZXN0aW9uLg0KDQpUaGlzIG1lc3NhZ2Ugc2hvdWxkIG9ubHkgcHJpbnQgd2hl
biB0aGUgdHdvIGRldmljZXMgKHByb3ZpZGVyIGFuZCBjbGllbnQpIGFyZToNCiAgLSBOb3QgYmVo
aW5kIHRoZSBzYW1lIHJvb3QgY29tcGxleA0KICAtIFRoZSBob3N0IGJyaWRnZSBjb25uZWN0aW5n
IHRoZW0gaXMgbm90IHdoaXRlbGlzdGVkDQoNCldpbGwgdXBkYXRlIHBhdGNoIGFuZCBwb3N0IGl0
IGZvciByZXZpZXcNCg0KUmVnYXJkcywNClJhbWVzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KU2Vu
dDogV2VkbmVzZGF5LCBOb3ZlbWJlciA2LCAyMDI0IDM6NTAgUE0NClRvOiBFcnJhYm9sdSwgUmFt
ZXNoIDxSYW1lc2guRXJyYWJvbHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBJbmZvcm0gaWYgUENJZSBi
YXNlZCBQMlAgbGlua3MgYXJlIG5vdCBhdmFpbGFibGUNCg0KDQpPbiAyMDI0LTExLTA1IDIwOjE5
LCBSYW1lc2ggRXJyYWJvbHUgd3JvdGU6DQo+IFJhaXNlIGFuIGluZm8gbWVzc2FnZSBpbiBrZXJu
ZWwgbG9nIGlmIFBDSWUgcm9vdCBjb21wbGV4IGRldGVybWluZXMNCj4gdGhhdCBhIEFNRCBHUFUg
ZGV2aWNlIEQ8aT4gY2Fubm90IGhhdmUgUDJQIGNvbW11bmljYXRpb24gd2l0aCBhbm90aGVyDQo+
IEFNRCBHUFUgZGV2aWNlIEQ8aj4NCj4NCj4gU2lnbmVkLW9mZi1ieTogUmFtZXNoIEVycmFib2x1
IDxSYW1lc2guRXJyYWJvbHVAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gaW5kZXggMjMwYzI0NjM4YTM0Li5hYjMwNGEyYzRhYWYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTYyMjIsNiArNjIy
Miw4IEBAIGJvb2wgYW1kZ3B1X2RldmljZV9pc19wZWVyX2FjY2Vzc2libGUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgIGJvb2wgcDJwX2FjY2VzcyA9DQo+ICAgICAgICAgICAg
ICAgIWFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUgJiYNCj4gICAgICAgICAgICAgICAh
KHBjaV9wMnBkbWFfZGlzdGFuY2UoYWRldi0+cGRldiwgcGVlcl9hZGV2LT5kZXYsIGZhbHNlKSA8
IDApOw0KPiArICAgICBpZiAoIXAycF9hY2Nlc3MpDQo+ICsgICAgICAgICAgICAgcHJfaW5mbygi
UENJZSBiYXNlZCBQMlAgbGlua3MgYXJlIG5vdCBhdmFpbGFibGVcbiIpOw0KDQpUaGlzIG1lc3Nh
Z2Ugd291bGQgYmUgYSBsb3QgbW9yZSB1c2VmdWwgaWYgaXQgdG9sZCB5b3UsIHdoaWNoIHR3byBk
ZXZpY2VzIGFyZSBhZmZlY3RlZC4gWW91IGNhbiB1c2UgZGV2X2luZm8gdG8gaGF2ZSBpdCBwcmlu
dCB0aGUgUENJZSBCREYgb2YgYWRldi4gVGhlbiB5b3Ugb25seSBuZWVkIHRvIHByaW50IGFkZGl0
aW9uYWwgaW5mb3JtYXRpb24gZm9yIHBlZXJfYWRldiB1c2luZyBwY2lfbmFtZShwZWVyX2FkZXYt
PnBkZXYpLg0KDQpBbHRlcm5hdGl2ZWx5LCB5b3UgY2FuIGp1c3Qgc2V0IHRoZSBsYXN0IHBhcmFt
ZXRlciBvZiBwY2lfcDJwZG1hX2Rpc3RhbmNlIHRvICJ0cnVlIi4gQWx0aG91Z2gsIHRoYXQgd2ls
bCBwcm9kdWNlIG1vcmUgc2NhcnktbG9va2luZyB3YXJuaW5nIG1lc3NhZ2VzLiBJIGJlbGlldmUg
TGlqbyBkaXNhYmxlZCB0aGF0IGF0IHNvbWUgcG9pbnQgYmVjYXVzZSBvZiB0aGF0IHJlYXNvbi4N
Cg0KUmVnYXJkcywNCiAgRmVsaXgNCg0KDQoNCj4NCj4gICAgICAgYm9vbCBpc19sYXJnZV9iYXIg
PSBhZGV2LT5nbWMudmlzaWJsZV92cmFtX3NpemUgJiYNCj4gICAgICAgICAgICAgICBhZGV2LT5n
bWMucmVhbF92cmFtX3NpemUgPT0gYWRldi0+Z21jLnZpc2libGVfdnJhbV9zaXplOw0K
