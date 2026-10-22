Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C329606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S3CYQTcj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD71311236D;
	Thu, 22 Oct 2026 06:57:41 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E793112390
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 06:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5l00pGlQPqGrYSCj+/Yh6GnXraP2KyIFhGBGCcvTmpg6SO+80/w2C/u0MQ2kydpCAGxnVPcvt314FsthEwX8gFL0oJ/y3NlhAWiDME/DbLgxGPPHUtB6rICsHpYCH5iIw2s53luVJ1Xf7eoyEGdhweB8HrCNZBvOUsX3iTKbYfh9CjMdb34hZwkiy156MtMW3K2/i9LYWBfwmpF8A5ZMs3exIXRs7FqrnLmxk86HtpQOnHUBXrLSQ61GsstayXmZaYmV9ZYQmWz/5UdNdbfb888CElCc+vFR7bWmkULZJszsrCPh/hhHnarpKg5EzniFKKSBIPYw56bQB98/2N/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPzb7Q4Ns4AoO/swqKOaQpLizN36913XSrdpGlq6hB0=;
 b=BZLmct4/CV7IPJ8CNYZJ4Odj/+AmfuBrx2NZjlos6Adoo8/Ciyf4HO37Gb7R6vPWdkIAUDIvPiR9HxG67d1/nRcyi6udGfeBhxK1UcZpRNRowojcl33R4MkytO/w9VYEs/7za4pdm9aJcwW/UFfumUys5K4nTTirUaM/ZYGZG6kuWCELzzLZmoARw7k2FjbLe6Wf4W6xBGhZjBJZng/7im6FQAIdZmq8Nm1L8eEyC7I3I02rWHCluK19BIz34sOCSHVhThf41NjFlSt3C8GKaXkxJsgKX1hfaNPZCKIQbMBDN51qJEpwCIYFT5fSA5ASO7M1zAWH+dhNg6UjAx14yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPzb7Q4Ns4AoO/swqKOaQpLizN36913XSrdpGlq6hB0=;
 b=S3CYQTcjgeszspQnNyurElGCI4xVGZyS6P4fV3T5YkZ6zQhahND1UExZVDHUSPkAzeVhdVaIBR+8s8c0LWTYCaJKe1cyMIiTkr1p6G8o4tYDM0Ei+V7ig8yv6F0JLf0t3VAEltVEum65bvHdFi+O8CjR6HNR7kGYqOf9c4LiY9Q=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by CHXPR12MB999243.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 06:57:32 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 06:57:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Gadre, Mangesh"
 <Mangesh.Gadre@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Thread-Topic: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Thread-Index: AQHdYTzag2F/MhWdCE2LnPyKGtsV1LcIyxrQgAAOgICAAEkAEA==
Date: Thu, 22 Oct 2026 06:57:31 +0000
Message-ID: <BN7PPFFF39339DD00D475A022FD6F7BED04FC652@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261021091607.245415-1-cesun102@amd.com>
 <BN7PPFFF39339DD155315E1E27AD5DFB060FC652@BN7PPFFF39339DD.namprd12.prod.outlook.com>
 <BN9PR12MB525882B57116D93B788066B09D652@BN9PR12MB5258.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525882B57116D93B788066B09D652@BN9PR12MB5258.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-22T02:35:44.4720000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|CHXPR12MB999243:EE_
x-ms-office365-filtering-correlation-id: bb4e3095-8c3d-4259-fc2c-08df3009be85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18092099006|10086099003|18002099003|22082099003|261021123027099003|8096899003|38070700021|5023799004|4143699003|11063799006|10067099003|261009223027099003|261021121427099003|56012099006;
x-microsoft-antispam-message-info: eoAlLfoDaa+ReFDFtNDln88NvhF9KBUk4bNViGcHt/LE41N4QGStcp3MPWIA8wEg5WNzPbiKCfTR+3DuwWDXmMj3lLnVEJiO5on+NaNw6imlFdyY2QJJHUyJHCMSTTLerZbu5/7Z32HXrPp3RMvJEvTUeI91rMZ/bedxoumAaBvRLw/wfImVdhBtIYRyiKVlPsnDIoyBQp9JcO1LIhZpq7QVqIPvN9zOVA6eLCiSXE8h/d7qJRX684BZCGfubo+DRCF6dBVrK6d7b7HFpnwlDMaRrLgIs9jFeE8NOJOOgOt+fhfLGx6gGC8uGIyXwW+CmPnXe6L7Hnr5ddSS51gl4qT3hI0a7SipoJAeYg0Fh2oqi5JjrSyspdyfOJYs8MmS6Q3czuqio73+eW/PWV1tXssOm/CW+SZm3++UXU5AN2xuEjrvQgLenIA4A/HhObGgRPgsWFLesTC/3ZHcKGe2ascE6952uKSnNNdTrc9WBbm3mq0QYdHx1pTUC3iPFlzj5GXiJxkfU8gWXUdZZg+/GwWwNjlSa1CjZbX3BeOn2H8pf5AEXoJAKHrhnXcEQ6nCpN7Zie7QRuzdk840GKOI3l34iIQ6/GZSwlb2EK4xjCQmz5KKpQNFN7jNITUhuRDTiSanZMAfPHj/Obbhy4AXk9mVbrstGwgf0PwyA6TGm9inq/yyeb7syYWsBHz0hZdv/WYU8RQtlXAWehH+qDI7APcxsQQt5H2SxzJRUE5mpa4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18092099006)(10086099003)(18002099003)(22082099003)(261021123027099003)(8096899003)(38070700021)(5023799004)(4143699003)(11063799006)(10067099003)(261009223027099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0LqVA1aCr9Wq6ehCYAh+gEmWnZILdYtPl1Qi9cLmIoi20bBONupqJsX4Akau?=
 =?us-ascii?Q?P8+c6VHAWol27LqCZmYF0NJ470NURjOrwh96ZapzCMJNJGq4ctKGlGTz059p?=
 =?us-ascii?Q?YovSEWRebfo7MhIKsa43o/RBVL68RYyVV0LG36AqYlRX8HX7ze9Tqv9x1Quj?=
 =?us-ascii?Q?2YVWGvKCwwmEt5aZwP+9vQzO1WKlO24HeIsJUg54DzMM5RAguAKi/5nRaN6K?=
 =?us-ascii?Q?T/tafJVNBTBPHRBqaPbUF2lCx87axH+mIVt+SGMek4G/ntS9tXE8sVdsup7Z?=
 =?us-ascii?Q?URosyVx9VBMkOe0ZlS94ZHWao8i3uKZp8/gcB2DDDp42nf/mO1PW7jv9ivrb?=
 =?us-ascii?Q?N191PC2FTO06Z9WMf6bpaIVh7owsa0I5Q8Fp0Xi0qptnOkgK7eFUKksYqiMN?=
 =?us-ascii?Q?MVxhlDID6pKAhLuwra+KjcIIpVmoLheYNlfc5Z2zLu5F0Im7I0XWSVYbo4bZ?=
 =?us-ascii?Q?2ojuW8c84ZTmqoPXwXvAPFuozSfDSWTSZtQkKFYuw0OhY3IG2m2rCQ6abWdm?=
 =?us-ascii?Q?/k+Oe88baOxJs+PApjzpgqpF23CUvmamiYnmMUhBcof+GEmeKqUKGHzw7xEB?=
 =?us-ascii?Q?T4Zq3rdso5UvqTdPRuOxr4q2eDzUIG0sM8jJEpTT2YqNOy7FejKMfwLRr+0i?=
 =?us-ascii?Q?gu0eat5gVYiL7JXgtWwGWWVWMVQfvs1iz9hjRxz4jMgsSe8aypBGsXq7oUKp?=
 =?us-ascii?Q?3GYmSYGbd+jHkvXO68mtyOws3DszvJVPD5zupteUKMghx+LWpM1Sxbnsn3Wh?=
 =?us-ascii?Q?7PYbZ8bCqu7P9zIDszNmL+EI8IG4gJz4nbScNaVzeoq+m+p076RivsmcDgK9?=
 =?us-ascii?Q?HaIVw0AQWu5SfotwJ1L4HDPTNRuLOH1+lUsawAkG43EXZgExOHCqfoBTqmFD?=
 =?us-ascii?Q?B4NYFl2V2KujSmaxBv8hkx3Kh1hwBUgvFwA/jbxFiGFhmFVtlyiNtISHQ/xj?=
 =?us-ascii?Q?AY52PvooI7HWK5QQqQrNhQJSbxb9NRhPy7lGEQgT898DD1YWRlsabkt/fOgF?=
 =?us-ascii?Q?NK1srMtwPj7aIUx96FKuG5uyeo8NoUePez8JDLpBghHEUTC8PYnYvDAZgwzW?=
 =?us-ascii?Q?1pvr7+HAUQCAGo6JtBtxQGZDe1Z2n4h4FnKUjuQqGP6+Vib+7Jc5HObOzRzN?=
 =?us-ascii?Q?FKZCQXc7Tk98tYVYvhzla1a63rKqngZAk5wmJ3g8jEXidY7hSqbE/uMazfzQ?=
 =?us-ascii?Q?60IndMfKm9di0RMddwhU4yc4+gwZz4FDRX5W2448QpIZBYbMffnr42/NPbKa?=
 =?us-ascii?Q?Uzw7pgx8i8zVJawbBKNoAvlBVRcuQHIKP8nO3a75ocYkn0LLzFzIoj5paFLi?=
 =?us-ascii?Q?HOiMzS7I54Z8nqwRL8wTYNv/bjheftxn7FHrlzQPd+e0b7FWzjdGPo3KSMHN?=
 =?us-ascii?Q?xG0P348PKj3X8caHaYJqEtU+hfQPBHobpibaLoEy3tPS+nldWD2vO0UNky1o?=
 =?us-ascii?Q?uTMOptv54MD8a+XwFBD7dHKUIu7jLhVVb9PHYWMAvOupusIouBnxlz6Rbfnn?=
 =?us-ascii?Q?OJXAqyNd/eIVsZlQ4L9q3HOLVGmrKvO0THkxpooUP5AzAVMSRQDeX1BJrEh7?=
 =?us-ascii?Q?NRag45/hquOvBKrY61VBkPE7r0PaCFp0m9RvO5RhvS+UwB9TAa08cpoSRvUh?=
 =?us-ascii?Q?vIvhzfDvUhkW1w6GggR+UtkrBAEWpu1kkCjfm6bzb2fkVSyPtf9slxcoAjPT?=
 =?us-ascii?Q?v/3VBrtMGRWdmBuQwRAoe0lh6H2K6Bp+Vv0F6R1IUxxVT0FC?=
Content-Type: multipart/alternative;
 boundary="_000_BN7PPFFF39339DD00D475A022FD6F7BED04FC652BN7PPFFF39339DD_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4e3095-8c3d-4259-fc2c-08df3009be85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 06:57:31.8594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLnhYzm9Z3tORYwWa52GKYw/jYrl+Mw8bHKesv66+l4USEojVUrbW8YnjTlIvfQ7FHReA8A2oGsm7sVwMgBguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_BN7PPFFF39339DD00D475A022FD6F7BED04FC652BN7PPFFF39339DD_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, October 22, 2026 10:36 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yan=
g, Stanley <Stanley.Yang@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode

AMD General

Hi Hawking,
Thanks for the review. The current changes are based on the legacy RAS impl=
ementation approach.
I'll further investigate the specific reset operation that is triggering th=
e security violation. In the meantime, I'll also try modifying the flow by =
either skipping the reset for the affected IPs or removing the direct reset=
 call altogether where the security violation occurs.

Regards,
Ce

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, October 22, 2026 9:49 AM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.free=
desktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhou1, =
Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Stanley.Y=
ang@amd.com<mailto:Stanley.Yang@amd.com>>; Gadre, Mangesh <Mangesh.Gadre@am=
d.com<mailto:Mangesh.Gadre@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode

AMD General

Hi @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>,

Have we identified the specific reset operation that is triggering the secu=
rity violation?

Would it make more sense to skip the reset, or remove the direct reset call=
 for the IPs where the security violation occurs?

In general, a reset is still required on some GFX v9_4_3 products to preven=
t stale or invalid error-counter data from being reported at initialization=
 time.

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>
Sent: Wednesday, October 21, 2026 5:16 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Stanley.Yang@a=
md.com<mailto:Stanley.Yang@amd.com>>; Gadre, Mangesh <Mangesh.Gadre@amd.com=
<mailto:Mangesh.Gadre@amd.com>>; Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:C=
e.Sun@amd.com>>
Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode

Fixes: c65c9fc19b6e ("drm/amdgpu: retire legacy ACA support")

After legacy ACA support was retired, some ASICs systems may trigger securi=
ty violations during driver load when
amdgpu_ras_reset_error_count() is invoked in debug mode.

The function only checks whether RAS is supported for the target block befo=
re proceeding. In debug mode, ACA/RAS handling is not available and attempt=
ing to access the reset path can lead to unexpected HW accesses, resulting =
in security violation reports during driver initialization.

Prevent this by treating debug mode as unsupported for RAS error count rese=
t and return -EOPNOTSUPP early.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 557baca454a9..e8a4fe22317f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1506,7 +1506,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
                 return -EOPNOTSUPP;
         }

-       if (!amdgpu_ras_is_supported(adev, block))
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_mgr_get_debug_mode(adev))
                 return -EOPNOTSUPP;

         if (amdgpu_sriov_vf(adev))
--
2.34.1


--_000_BN7PPFFF39339DD00D475A022FD6F7BED04FC652BN7PPFFF39339DD_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">The patch is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.co=
m&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Hawking<o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Sun, Ce(Overlord) &lt;Ce.Sun@a=
md.com&gt;
<br>
<b>Sent:</b> Thursday, October 22, 2026 10:36 AM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Gadre, Mangesh =
&lt;Mangesh.Gadre@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: skip RAS error count reset in debug=
 mode<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"margin-top:12.0pt;margin-bottom:12.0pt">
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"color:bl=
ack">Hi Hawking,<o:p></o:p></span></p>
</div>
<div style=3D"margin-top:12.0pt;margin-bottom:12.0pt">
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"color:bl=
ack">Thanks for the review. The current changes are based on the legacy RAS=
 implementation approach.<o:p></o:p></span></p>
</div>
<div style=3D"margin-top:12.0pt;margin-bottom:12.0pt">
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"color:bl=
ack">I'll further investigate the specific reset operation that is triggeri=
ng the security violation. In the meantime, I'll also try modifying the flo=
w by either skipping the reset for the
 affected IPs or removing the direct reset call altogether where the securi=
ty violation occurs.<o:p></o:p></span></p>
</div>
<div style=3D"margin-top:12.0pt;margin-bottom:12.0pt">
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"color:bl=
ack"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"line-height:15.0pt"><span style=3D"color:bl=
ack">Regards,<br>
Ce<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Zhang,=
 Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com=
</a>&gt;<br>
<b>Sent:</b> Thursday, October 22, 2026 9:49 AM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@a=
md.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Ta=
o.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@a=
md.com">Stanley.Yang@amd.com</a>&gt;; Gadre, Mangesh &lt;<a href=3D"mailto:=
Mangesh.Gadre@amd.com">Mangesh.Gadre@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: skip RAS error count reset in debug=
 mode</span>
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">AMD General</span><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p=
>
<div style=3D"margin-top:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Hi
<a href=3D"mailto:Ce.Sun@amd.com"><span style=3D"color:#2B579A;background:#=
E1DFDD">@Sun, Ce(Overlord)</span></a>,</span><span style=3D"font-size:10.0p=
t;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Have we identified the specific reset operation tha=
t is triggering the security violation?</span><span style=3D"font-size:10.0=
pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Would it make more sense to skip the reset, or remo=
ve the direct reset call for the IPs where the security violation occurs?</=
span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">In general, a reset is still required on some GFX v=
9_4_3 products to prevent stale or invalid error-counter data from being re=
ported at initialization time.</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Regards,</span><span style=3D"font-size:10.0pt;font=
-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Hawking</span><span style=3D"font-size:10.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@amd.co=
m</a>&gt; <br>
Sent: Wednesday, October 21, 2026 5:16 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"=
>YiPeng.Chai@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@am=
d.com">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanl=
ey.Yang@amd.com">Stanley.Yang@amd.com</a>&gt;;
 Gadre, Mangesh &lt;<a href=3D"mailto:Mangesh.Gadre@amd.com">Mangesh.Gadre@=
amd.com</a>&gt;; Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce=
.Sun@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Fixes: c65c9fc19b6e (&quot;drm/amdgpu: retire legac=
y ACA support&quot;)</span><span style=3D"font-size:10.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">After legacy ACA support was retired, some ASICs sy=
stems may trigger security violations during driver load when</span><span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">amdgpu_ras_reset_error_count() is invoked in debug =
mode.</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;=
,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">The function only checks whether RAS is supported f=
or the target block before proceeding. In debug mode, ACA/RAS handling is n=
ot available and attempting to access the reset
 path can lead to unexpected HW accesses, resulting in security violation r=
eports during driver initialization.</span><span style=3D"font-size:10.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Prevent this by treating debug mode as unsupported =
for RAS error count reset and return -EOPNOTSUPP early.</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Signed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun10=
2@amd.com">cesun102@amd.com</a>&gt;</span><span style=3D"font-size:10.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">---</span><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-</sp=
an><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">1 file changed, 2 insertions(+), 1 deletion(-)</spa=
n><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index 557baca454a9..e8a4fe22317f 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -1506,7 +1506,8 @@ int amdgpu_ras_reset_error_co=
unt(struct amdgpu_device *adev,</span><span style=3D"font-size:10.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</span><sp=
an style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_r=
as_is_supported(adev, block))</span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_r=
as_is_supported(adev, block) ||</span><span style=3D"font-size:10.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !amdgpu_ras_mgr_get_debug_mode(adev))</span><span style=3D"font-=
size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</span><sp=
an style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (amdgpu_sriov_vf(adev))</span><span style=3D"font-size:10.0pt;font-family:=
&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--</span><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">2.34.1</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BN7PPFFF39339DD00D475A022FD6F7BED04FC652BN7PPFFF39339DD_--
