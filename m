Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_05,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D81BC4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07262222C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="ZEHyzS9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07262222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF9A6E95B;
	Mon, 26 Oct 2020 15:31:27 +0000 (UTC)
Received: from sonic313-19.consmr.mail.gq1.yahoo.com
 (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051AC6E95B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
 t=1603723865; bh=4OYHjTCszK8GvZu8W0BpB7EzFLIyHiiZ9TURM4OtAuA=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject;
 b=ZEHyzS9sQyFKFK+RHeOY9B8TSHnN4OZY3dfyOTYQwzqvKqj1uhjvvR6ODNWMhBgcRfpUTeRxqp9PFuyi7VFAtd/OO4pwesqywBI7fe1lnoSihkSdacntJ1C15i8VAcWCbF0xNCUWgk88FTUC3ZTKzJsF8sS6N9L/8Ts52OVbmb4oYEg0XAx40H+g3lb5qbb0ZGlEOh0/tylKdaCxRtMgcdnBj7HyTijtg2s7/11vJP4F8QIPTLnhsYZunEfze546kOgq2PV2onb/O6hMS2DkNngScCA9RkEqewJkdujR/DAmKbR/4eZDGoLSG09B+Jb9g4yXxWUFtjZrBPnwofBeFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603723865; bh=EDfTfPvioQe8PpCrMRwtiSBS+QGvFsHcTcv+lujoYCg=;
 h=Date:From:Subject:To;
 b=HLrzTMbv5fXTW/2cP3WZjmNYB3tq6TgnqdoQ8Gf2NArn29ecltb0emYKTYnGzXOQdqGcDWYAxhMn0hOWZEdoVm7d9k1U06coF+1lo1jAUM4OTeoBpWopC8R5BDVNL5WRBam0i/OtwgNWq3g+21fXsR/xz+9399K54eaSpCHqX3Ckam/uf9D4KXD9Vbo//exUE9CDiI3vnRZvIvPzMOGZCrfero7uOfbJli9QDroph4yojw/VvoOHyQqCvlMGLslR3ViPpon95G63XlGGIFufB62HDBh2ME4tBRzq6lPLeo6fqwMvP3DP7kKNgdtYh43Gi2lS5C1KjxNCzuTa0X87Ww==
X-YMail-OSG: s3zOwNQVM1kQrhKa._rq9FhTLdJTucN.TiYwzxsGqotBCZh8ic1_WgSXgh3Vd7E
 yDRf286BSUrHndTXDa29RmOHdTNCvQpbs0PIm4x0oN8euUbyfdWS9dQQ.qf1q0fV4VWs005KwPlt
 83i0SInZS4unl2n449n7XQT7iyiZCm0zfQbeeEf.ww7PLi.n7wjWwvyQsTviKrLeXv8M3lIVeFNM
 SM0_tME.6moLBnHCW4XRlrFjOuSBbqN_zyUKiLWvYwNuBUI_cOFp_YA5LYWRNiW8E_557UxUTvqL
 _uefpxhwQml4BNQBku2vYbFAHp0frDUwlTxobTyA5D0mG3ykEisshICSzetSEDUsyqrAXrSOf_FF
 an9vSm54KWpxYwVnHN0KLG1qW5G8zt68Wc_miFOw6fxyZvAkqS3mm59DihEN1O.SBVmjs3S_.M35
 gqXSYdF5.xfZJjGGcSr_UlhCNupqr8SL0OYAbgXgon_HFbsGZE.q21rG7ilkco0Ycr6A4vGiU9cd
 BwP2Q5eOAdlM9vBbiByLo7bD3hmDS_BPWF1jLESF7JatuzrS9Jq1S4lRdBwShWekawP_QQUql0CL
 vLOvbtIRa9C7UtXAgxz2o0fBJ59VqFMvV6Xku1vYtH9TZL9RL4FROnxdaWT39hYzkOYIhtxOeock
 TZtzhkY.C8EF5HiZxmlySyXhj4MAn41QLQTgAANGi3GMqYnuAlx2qKnnX.Rsuj25ts3QPHR1iVGp
 4LLAV6cDg7D7lV9zuvOF3LoF83bOmNyhulAoMph2iSgGgmV3AemT06GlBFBKmTp90KFvMd7nj12n
 nr9zwqgaBk6BzMWZxGuC0kHNMv2VgvFzUCJskxTGyeUqsqGTrkDrdzfT0r2erBHqff51CqvAoZGs
 bEdlhQG7mMtI6GTkJfnv7QZ5psaTn99bBJc2fYr06.cKSHrLwg0gkWPHEQTkHZpYwIJaR_xCZ0n2
 5iYC35gqMZYcbTZNTtG3aashlLzZy51MDOKdZlyzeqcw4N0WI0iD_jbCc9fcA2kFfZ6FGhbUxzA2
 tlvp7wWJhEoPwYUZBhFXttsfsodcz.KK1CbwzJ2vLx7bcarSBzxhiCYIpAj_GgZ32nnv2pMcl54f
 9RCJ.fMpXvwYZZn9g3QrCwrpZblH6tH5bnluf56tripIQRF5l4oMnRQKlcyP7gwGDJgQ0S8O4ATH
 ChRpsLhCAAs.pM6VaN89sG7OG3I6owdupHjgqII3SBydr5Ry9lDXZ3kTm0mPD26g1onYlDLyQ.TJ
 WEwjIRNiS6DQy.c5a__ciqRq.Qeozj4BDHBVwT9Pzgchgrpz7KooxvDcb9FumFVH9otn1cs_8Egm
 zg6rBVB50VZAu12ipoEK.8_nuq1fRef0RREUihomvOI13dEfgtsfg9Vy7IQerFI7x7XNbP6PJ9Ys
 8aK8YIwwVeRrlcHZsV4paV0I.rfDmOSXIXl1XWm19Nkm.oCsETACJqrAOMPhlsfF8wRA51xjRNwZ
 zKLDRpi4CS2org5HmGFRWO6oO9JnF0zaxEUJMhprIQJO76cD5tq79YhuhUeRe3ED2wxcQgbnJaSH
 Gq39PMbugae61Ewi7LsQaMeFchAvC5hmYqCfmPgxwZD910E_UpLTuUtCWdhm5U9JO6JhDFs9WPeJ
 VsdIvcu8CcdMGgloHW3ivCCXT_dFpDcY2.p4pg5nd33u.PGUNbJbCcyIy8mnYTa8JSXXSNyjTBZQ
 mJMg3NF6hiA9dRoxKty.6VCzeMLUz0NhHt4AbxZQxzGFvSs.C73g4aebtDcuGebaH016ZGvZR79n
 ymqizFksXOnxxv4CKGWEx3RLiVHTGDV1RFHcBI6Rx3oqtYfO5p4o1VrQJBKewWqvH54_A.OJRQrp
 Mz.vAr.SDdCTZe0Q3Y5PvOri7TF8EBmJ5_SJPu06vDJG1WwbERrekTHELzVkcBvf27stGGUrFGdH
 jXXHvmO9jzUEKOPgExpf1MSa7qdjgxXj9w0dcr1rdGKJl6XoGy0VeSYgQztP31sM9nF.z6tcLwAn
 Aaj1U9Hpn7lrbjZaeFjhrVAHbgyAhWUHWJJPhHfUw58LEp23xGWnsZ5wptOvcYpbInYeSpZTWNct
 rNSUIRsJHSB228RHYU3G1BqvA9HWprKMWt8g_6d_gTIftB7SuLv3pgwo0TZpQoJRQZzvG1cv5foG
 TOfHd41quJ5UoC5tntu09x6h3G4g5XZ4GbYrk4ThWpgr4Su928tiiMjWM2HQdeN99llElqrZc7nZ
 4h52MxaizvFVug5UQoFBXaR5R7Rize43QMsMBp6RKXWGNhmkSvDj4kSqHcsR_LYqJReCnd04Jggx
 N0WEOW2sQd.YsPoEt1NwjbADwggRsSwr4EIVUKSpppSDtcR_FkPDL8Cv9bC7tDHhjjAb0bmmqUC1
 BX56z52UEJ3sEO3AQ46zZTCX_ItGX1yAd9_7WRC1DHoUNSIhIoLSL00JwZlMCaKKt01eEi62sOr4
 oPLsL52moeiWYuI6MpMmIcLtnR5kUuYLHI1l5CSVq.FadQ2mEz2Ejq1bHu9TkONofx2jRHYM3YV0
 U51TvYOnENx8o6iQTC3CKtOkidZpyHXcfJXiKZDznZsZiGPQdi.7tcs7nGYyiY17nQmsk5Jo27tD
 QEGmYJBBiddZB8gvI1fSF3CeViSQdSnW_IDv7GGtBArVZfyUlBioytNYSgIkQVDwc.wW.s0d6.rv
 FSN.4x7H1oPO1QmDfI9FfoWkIPef8GR92mnsrPvofewewtevZZZBfknL2EolHA_kmZ94nfJMzo9z
 _QZNGv3gJQpB5wibgGcq.LXtAED9y3QJVNSeELcnT4lb6Pf2FEGV4wHnJ9Ke.WQ4.g06vRcMVvmM
 KZ4s5cH2155Z4_G2ycilj3bBT4PrFhNecMtJZtQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 26 Oct 2020 14:51:05 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID c2e5d046a1da2e09e18cb22615934b6d; 
 Mon, 26 Oct 2020 14:51:00 +0000 (UTC)
Date: Mon, 26 Oct 2020 10:50:55 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: RE: amdgpu crashes on OOM
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, Michel =?iso-8859-1?q?D=E4nzer?=
 <michel@daenzer.net>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
References: <1603684905.h43s1t0y05.none.ref@localhost>
 <1603684905.h43s1t0y05.none@localhost>
 <81568253-518f-43b7-6b20-432f7dbd6c2b@daenzer.net>
 <MN2PR12MB448824F6E08D1498206EFFE6F7190@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448824F6E08D1498206EFFE6F7190@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Message-Id: <1603723649.ang5tduo62.none@localhost>
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
X-Mailman-Approved-At: Mon, 26 Oct 2020 15:31:27 +0000
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Excerpts from Deucher, Alexander's message of October 26, 2020 10:34 am:
> It was using kvzalloc, but was accidently dropped when that code was refactored.  I just sent a patch to fix it.

Ah, that explains why I wasn't seeing it before. I was only looking at 
changes in amdgpu_dm_atomic_commit_tail, not dc_create_state.

Thanks,
Alex.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
